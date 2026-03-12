#!/usr/bin/env python3

from __future__ import annotations

import os
import shutil
import subprocess
import sys

LINE_LIMIT = 200

COLOR_OK = "\033[32m" if sys.stderr.isatty() else ""
COLOR_WARN = "\033[33m" if sys.stderr.isatty() else ""
COLOR_ERR = "\033[31m" if sys.stderr.isatty() else ""
COLOR_RESET = "\033[0m" if sys.stderr.isatty() else ""


def has_cmd(cmd: str) -> bool:
    return shutil.which(cmd) is not None


def log_warn(msg: str) -> None:
    print(f"{COLOR_WARN}[lessfilter.py] {msg}{COLOR_RESET}", file=sys.stderr)


def log_err(msg: str) -> None:
    print(f"{COLOR_ERR}[lessfilter.py] {msg}{COLOR_RESET}", file=sys.stderr)


def print_help() -> None:
    print("Usage:")
    print("  lessfilter.py <path>")
    print("  lessfilter.py help")
    print("  lessfilter.py doctor")
    print("")
    print("Commands:")
    print("  help    Show this help message")
    print("  doctor  Check external tool availability")


def print_doctor_item(name: str, state: str, detail: str = "") -> None:
    if state == "ok":
        color = COLOR_OK
    elif state == "warn":
        color = COLOR_WARN
    else:
        color = COLOR_ERR
    suffix = f" ({detail})" if detail else ""
    print(f"{color}[{state.upper():5}] {name}{suffix}{COLOR_RESET}")


def doctor() -> int:
    fatal = 0
    warns = 0

    required = ["file"]
    for cmd in required:
        if has_cmd(cmd):
            print_doctor_item(cmd, "ok")
        else:
            print_doctor_item(cmd, "error", "required")
            fatal += 1

    if has_cmd("bat") or has_cmd("batcat"):
        if has_cmd("bat"):
            print_doctor_item("bat|batcat", "ok", "using bat")
        else:
            print_doctor_item("bat|batcat", "ok", "using batcat")
    else:
        print_doctor_item("bat|batcat", "warn", "syntax highlight fallback reduced")
        warns += 1

    optional = [
        "eza",
        "pygmentize",
        "jq",
        "pdftotext",
        "chafa",
        "exiftool",
        "in2csv",
        "xsv",
        "wv",
        "pandoc",
        "mediainfo",
        "highlight",
    ]
    for cmd in optional:
        if has_cmd(cmd):
            print_doctor_item(cmd, "ok")
        else:
            print_doctor_item(cmd, "warn", "optional")
            warns += 1

    if fatal:
        print(f"\n{COLOR_ERR}Doctor result: FAIL ({fatal} critical missing){COLOR_RESET}")
        return 1

    if warns:
        print(f"\n{COLOR_WARN}Doctor result: WARN ({warns} optional missing){COLOR_RESET}")
    else:
        print(f"\n{COLOR_OK}Doctor result: OK{COLOR_RESET}")
    return 0


def run_capture(cmd: list[str], input_data: bytes | None = None) -> bytes | None:
    try:
        proc = subprocess.run(
            cmd,
            input=input_data,
            check=False,
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL,
        )
    except OSError:
        return None
    if proc.returncode != 0:
        return None
    return proc.stdout


def run_passthrough(cmd: list[str]) -> bool:
    try:
        proc = subprocess.run(cmd, check=False)
    except OSError:
        return False
    return proc.returncode == 0


def render_file(path: str) -> None:
    if has_cmd("bat"):
        run_passthrough(
            ["bat", "--color=always", "--paging=never", "--line-range", f":{LINE_LIMIT}", path]
        )
        return
    if has_cmd("batcat"):
        run_passthrough(
            ["batcat", "--color=always", "--paging=never", "--line-range", f":{LINE_LIMIT}", path]
        )
        return
    with open(path, "rb") as f:
        data = f.read()
    render_bytes(data)


def render_bytes(data: bytes, language: str | None = None) -> None:
    lines = data.splitlines()
    payload = b"\n".join(lines[:LINE_LIMIT])
    if payload and not payload.endswith(b"\n"):
        payload += b"\n"

    if has_cmd("bat"):
        cmd = ["bat", "--color=always", "--paging=never", "-p"]
        if language:
            cmd.append(f"--language={language}")
        result = run_capture(cmd, input_data=payload)
        if result is not None:
            sys.stdout.buffer.write(result)
            return

    if has_cmd("batcat"):
        cmd = ["batcat", "--color=always", "--paging=never", "-p"]
        if language:
            cmd.append(f"--language={language}")
        result = run_capture(cmd, input_data=payload)
        if result is not None:
            sys.stdout.buffer.write(result)
            return

    sys.stdout.buffer.write(payload)


def file_mime(path: str) -> str:
    out = run_capture(["file", "-bL", "--mime-type", path])
    if not out:
        return "application/octet-stream"
    return out.decode(errors="replace").strip()


def show_basic_file_info(path: str) -> None:
    out = run_capture(["file", "--brief", path])
    if out is not None:
        sys.stdout.buffer.write(out)
        return
    print(f"File: {path}")


def preview_directory(path: str) -> None:
    if has_cmd("eza"):
        run_passthrough(["eza", "--git", "-hl", "--color=always", "--icons", path])
        return
    log_warn("missing command: eza; falling back to ls")
    run_passthrough(["ls", "-lah", path])


def preview_image(path: str) -> None:
    shown = False
    if has_cmd("chafa"):
        run_passthrough(["chafa", path])
        shown = True
    else:
        log_warn("missing command: chafa")
    if has_cmd("exiftool"):
        run_passthrough(["exiftool", path])
        shown = True
    else:
        log_warn("missing command: exiftool")
    if not shown:
        show_basic_file_info(path)


def preview_text(path: str) -> None:
    if has_cmd("pygmentize"):
        out = run_capture(["pygmentize", "-O", "style=one-dark", "-f", "terminal256", "-g", path])
        if out is not None:
            render_bytes(out)
            return
    render_file(path)


def preview_json(path: str) -> None:
    if has_cmd("jq"):
        out = run_capture(["jq", ".", path])
        if out is not None:
            render_bytes(out, language="json")
            return
        log_warn("invalid json; showing raw content")
    else:
        log_warn("missing command: jq; showing raw content")
    render_file(path)


def preview_pdf(path: str) -> None:
    if has_cmd("pdftotext"):
        out = run_capture(["pdftotext", "-nopgbrk", "-q", path, "-"])
        if out is not None:
            render_bytes(out)
            return
    log_warn("missing command: pdftotext or failed conversion")
    show_basic_file_info(path)


def preview_excel(path: str) -> None:
    if has_cmd("in2csv") and has_cmd("xsv"):
        csv = run_capture(["in2csv", path])
        if csv is not None:
            table = run_capture(["xsv", "table"], input_data=csv)
            if table is not None:
                render_bytes(table, language="csv")
                return
    log_warn("missing command: in2csv/xsv or failed conversion")
    preview_office(path)


def preview_office(path: str) -> None:
    if has_cmd("wv") and has_cmd("pandoc"):
        html = run_capture(["wv", "-p", "-c", "-nw", "-f", "text/html", path])
        if html is not None:
            txt = run_capture(["pandoc", "-t", "plain"], input_data=html)
            if txt is not None:
                render_bytes(txt)
                return
    log_warn("missing command: wv/pandoc or failed conversion")
    show_basic_file_info(path)


def preview_video(path: str) -> None:
    if has_cmd("mediainfo"):
        if run_passthrough(["mediainfo", path]):
            return
    log_warn("missing command: mediainfo")
    show_basic_file_info(path)


def preview_other(path: str) -> None:
    mime = file_mime(path)
    if mime.startswith("text/"):
        if has_cmd("highlight"):
            out = run_capture(["highlight", "-O", "ansi", path])
            if out is not None:
                render_bytes(out)
                return
        render_file(path)
        return
    show_basic_file_info(path)


def dispatch(path: str) -> None:
    if os.path.isdir(path):
        preview_directory(path)
        return

    mime = file_mime(path)
    if mime == "inode/x-empty":
        if path.endswith(".json"):
            preview_json(path)
        else:
            preview_text(path)
        return

    category, _, kind = mime.partition("/")

    if category == "image":
        preview_image(path)
    elif category == "text":
        preview_text(path)
    elif category == "video":
        preview_video(path)
    elif category == "application":
        if kind == "json":
            preview_json(path)
        elif kind == "pdf":
            preview_pdf(path)
        elif kind in {
            "vnd.ms-excel",
            "vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        }:
            preview_excel(path)
        elif kind in {
            "vnd.ms-word",
            "vnd.openxmlformats-officedocument.wordprocessingml.document",
            "vnd.ms-powerpoint",
            "vnd.openxmlformats-officedocument.presentationml.presentation",
        }:
            preview_office(path)
        elif kind == "vnd.gentoo.ebuild":
            preview_text(path)
        else:
            preview_other(path)
    else:
        preview_other(path)


def main(argv: list[str]) -> int:
    if len(argv) != 2:
        print_help()
        return 1

    arg = argv[1]
    if arg in {"help", "-h", "--help"}:
        print_help()
        return 0

    if arg == "doctor":
        return doctor()

    path = arg
    if not os.path.exists(path):
        log_err(f"path does not exist: {path}")
        return 1

    dispatch(path)
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
