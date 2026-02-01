#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import os
import shutil
import subprocess
import sys
import urllib.request
from pathlib import Path
from typing import Optional, Any

API_URL = "https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release"
PRODUCT_CODE = "TBA"

DEFAULT_PKG_DIR = Path("/var/db/repos/mystical-overlay/dev-util/jetbrains-toolbox")
DEFAULT_PN = "jetbrains-toolbox"

_xdg = os.environ.get("XDG_CACHE_HOME")
_cache_base = Path(_xdg) if _xdg else (Path.home() / ".cache")
CACHE_FILE = _cache_base / "jetbrains-toolbox" / "tba_latest.json"


def load_cache(cache_file: Path = CACHE_FILE) -> Optional[dict]:
    try:
        if cache_file.exists():
            return json.loads(cache_file.read_text(encoding="utf-8"))
    except Exception:
        return None
    return None


def save_cache(info: dict, cache_file: Path = CACHE_FILE) -> None:
    cache_file.parent.mkdir(parents=True, exist_ok=True)
    cache_file.write_text(
        json.dumps(info, ensure_ascii=False, indent=2), encoding="utf-8"
    )


def fetch_latest_release(api_url: str = API_URL, code: str = PRODUCT_CODE) -> dict:
    req = urllib.request.Request(
        api_url,
        headers={"Accept": "application/json", "User-Agent": "tba-version-check/3.0"},
    )
    with urllib.request.urlopen(req, timeout=10) as resp:
        if resp.status != 200:
            raise RuntimeError(f"HTTP {resp.status}")
        data = json.loads(resp.read().decode("utf-8"))

    # releases endpoint normally returns dict: {"TBA":[...]} but keep a fallback.
    releases = None
    if isinstance(data, dict):
        releases = data.get(code)
    elif isinstance(data, list):
        tba = next((x for x in data if x.get("code") == code), None)
        releases = (tba or {}).get("releases")

    if not releases:
        raise RuntimeError("missing releases in response")
    return releases[0]


def extract_current(latest: dict) -> dict:
    return {
        "version": latest.get("version", "Unknown"),
        "build": latest.get("build", "Unknown"),
        "date": latest.get("date", "Unknown"),
    }


def extract_links(latest: dict) -> dict:
    dl = latest.get("downloads", {}) or {}
    amd64 = (dl.get("linux") or {}).get("link")
    arm64 = (dl.get("linuxARM64") or dl.get("linuxArm64") or {}).get("link")
    return {"linux_amd64": amd64, "linux_arm64": arm64}


def _parse_ver_tuple(v: str) -> tuple:
    # JetBrains Toolbox version: 3.2.0.65851 (all ints); if unexpected, fallback to string.
    try:
        return tuple(int(x) for x in v.split("."))
    except Exception:
        return (v,)


def find_template_ebuild(pkg_dir: Path, pn: str, prefer_version: Optional[str]) -> Path:
    if prefer_version:
        p = pkg_dir / f"{pn}-{prefer_version}.ebuild"
        if p.exists():
            return p

    cands = list(pkg_dir.glob(f"{pn}-*.ebuild"))
    if not cands:
        raise FileNotFoundError(f"no ebuild found under: {pkg_dir}")

    def key(p: Path):
        ver = p.name.removeprefix(f"{pn}-").removesuffix(".ebuild")
        return _parse_ver_tuple(ver)

    return max(cands, key=key)


def bump_ebuild(
    pkg_dir: Path,
    pn: str,
    new_version: str,
    template: Optional[Path],
    prefer_version: Optional[str],
    dry_run: bool,
    run_manifest: bool,
) -> dict[str, Any]:
    pkg_dir = pkg_dir.resolve()
    if not pkg_dir.is_dir():
        return {"status": "error", "error": f"pkg_dir not found: {pkg_dir}"}

    dst = pkg_dir / f"{pn}-{new_version}.ebuild"
    if dst.exists():
        return {"status": "exists", "path": str(dst)}

    if template is None:
        try:
            template = find_template_ebuild(pkg_dir, pn, prefer_version=prefer_version)
        except Exception as e:
            return {"status": "error", "error": f"template resolve failed: {e}"}
    else:
        template = template.resolve()
        if not template.exists():
            return {"status": "error", "error": f"template not found: {template}"}

    if dry_run:
        return {"status": "dry_run", "path": str(dst), "template": str(template)}

    try:
        shutil.copy2(template, dst)
    except Exception as e:
        return {
            "status": "error",
            "error": f"copy failed: {e}",
            "template": str(template),
            "path": str(dst),
        }

    manifest_rc = None
    manifest_err = None
    if run_manifest:
        try:
            r = subprocess.run(
                ["ebuild", str(dst), "manifest"],
                cwd=str(pkg_dir),
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
                check=False,
            )
            manifest_rc = r.returncode
            if r.returncode != 0:
                manifest_err = (r.stderr or r.stdout or "").strip()[:1200]
        except Exception as e:
            manifest_rc = 127
            manifest_err = str(e)

    return {
        "status": "created",
        "path": str(dst),
        "template": str(template),
        "manifest_rc": manifest_rc,
        "manifest_err": manifest_err,
    }


def main() -> int:
    ap = argparse.ArgumentParser(
        description="Check JetBrains Toolbox (TBA) latest release with cache."
    )
    g = ap.add_mutually_exclusive_group()
    g.add_argument("--quiet", action="store_true", help="Minimal one-line output.")
    g.add_argument("--json", action="store_true", help="Output JSON only.")

    ap.add_argument(
        "--bump-ebuild",
        action="store_true",
        help="Copy an existing ebuild and rename to the new version.",
    )
    ap.add_argument(
        "--pkg-dir", type=Path, default=DEFAULT_PKG_DIR, help="Overlay package dir."
    )
    ap.add_argument(
        "--template-ebuild",
        type=Path,
        default=None,
        help="Explicit template ebuild path.",
    )
    ap.add_argument(
        "--manifest", action="store_true", help="Run: ebuild <new>.ebuild manifest"
    )
    ap.add_argument(
        "--dry-run",
        action="store_true",
        help="Do not write cache/ebuild; show what would happen.",
    )
    args = ap.parse_args()

    try:
        latest = fetch_latest_release()
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        return 1

    current = extract_current(latest)
    links = extract_links(latest)
    cached = load_cache()

    updated = (
        cached is None
        or cached.get("version") != current["version"]
        or cached.get("build") != current["build"]
    )

    # cache
    if updated and not args.dry_run:
        try:
            save_cache(current)
        except Exception as e:
            print(f"Warning: failed to write cache: {e}", file=sys.stderr)

    # ebuild bump
    ebuild_result = None
    if args.bump_ebuild:
        if updated:
            prefer_ver = cached.get("version") if isinstance(cached, dict) else None
            ebuild_result = bump_ebuild(
                pkg_dir=args.pkg_dir,
                pn=DEFAULT_PN,
                new_version=current["version"],
                template=args.template_ebuild,
                prefer_version=prefer_ver,
                dry_run=args.dry_run,
                run_manifest=(args.manifest and not args.dry_run),
            )
        else:
            ebuild_result = {"status": "skipped", "reason": "no update"}

    # JSON output
    if args.json:
        out = {
            "product": PRODUCT_CODE,
            "api_url": API_URL,
            "cache_file": str(CACHE_FILE),
            "updated": updated,
            "cached": cached,
            "current": current,
            "downloads": links,
            "ebuild": ebuild_result,
        }
        print(json.dumps(out, ensure_ascii=False))
        return 0

    # quiet output
    if args.quiet:
        if updated and cached:
            base = f"UPDATE {cached.get('version', '?')} ({cached.get('build', '?')}) -> {current['version']} ({current['build']})"
        elif updated:
            base = f"INIT {current['version']} ({current['build']})"
        else:
            base = f"NO_UPDATE {current['version']} ({current['build']})"

        if ebuild_result:
            st = ebuild_result.get("status")
            p = ebuild_result.get("path")
            extra = f" EBUILD:{st}" + (f":{p}" if p else "")
            print(base + extra)
        else:
            print(base)
        return 0

    # default output
    use_color = sys.stdout.isatty()
    green = "\033[1;32m" if use_color else ""
    reset = "\033[0m" if use_color else ""

    print(f"API:        {API_URL}")
    print(f"Cache file: {CACHE_FILE}")
    if updated and cached:
        print(
            f"Status:     [UPDATE] {cached.get('version', '?')} ({cached.get('build', '?')}) -> {current['version']} ({current['build']})"
        )
    elif updated:
        print(
            f"Status:     [INIT] cache created ({current['version']} / {current['build']})"
        )
    else:
        print("Status:     [NO UPDATE]")

    if ebuild_result:
        st = ebuild_result.get("status")
        print(f"Ebuild:     [{st}]")
        if ebuild_result.get("reason"):
            print(f"  reason:   {ebuild_result['reason']}")
        if ebuild_result.get("path"):
            print(f"  path:     {ebuild_result['path']}")
        if ebuild_result.get("template"):
            print(f"  template: {ebuild_result['template']}")
        if ebuild_result.get("manifest_rc") is not None:
            print(f"  manifest: rc={ebuild_result.get('manifest_rc')}")
            if ebuild_result.get("manifest_err"):
                print(f"  manifest_err: {ebuild_result['manifest_err']}")

    print("-" * 40)
    print(f"Version:    {green}{current['version']}{reset}")
    print(f"Build:      {green}{current['build']}{reset}")
    print(f"Date:       {current['date']}")
    print("-" * 40)

    if links["linux_amd64"]:
        print(f"[OK]  Linux AMD64: {links['linux_amd64']}")
    else:
        print("[WARN] Linux AMD64 link not found")

    if links["linux_arm64"]:
        print(f"[OK]  Linux ARM64: {links['linux_arm64']}")
    else:
        print("[WARN] Linux ARM64 link not found")

    print("-" * 40)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
