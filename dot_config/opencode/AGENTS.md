# Global Agent Rules

## Instruction Hierarchy

- Apply instructions in this order unless explicitly overridden for the
  current task: global rules, repository rules, then temporary
  task-specific instructions.
- If two instructions conflict, follow the higher-precedence source and
  state the conflict briefly.
- Direct system/developer/user instructions in the active session always
  take precedence over AGENTS instructions.
- Unless explicitly requested otherwise, follow these defaults.
- Tooling required by existing project dependencies is allowed even when
  a language/runtime is discouraged for new script authoring.

## Safety and Scope

- Ask for confirmation before destructive operations such as `rm -rf`,
  `git reset --hard`, or `git checkout --`.
- When supported, run a `--dry-run` before destructive or bulk
  operations.
- Do not modify unrelated files unless explicitly requested.
- Keep edits minimal, scoped, and reversible.

## Editing Rules

- Prefer built-in tools for file reads and writes whenever available.
- For file edits, prefer built-in edit tools (especially `apply_patch`)
  over shell-based edits.
- For file reads, prefer built-in resource/read tools when available;
  otherwise use minimal shell read commands.
- Avoid using `bat`/`cat` when a built-in tool can do the same job.
- Use `bat`/`cat` only as read-only fallbacks when built-in tools are
  unavailable.
- Do not write files using shell redirection (`>`, `>>`), heredoc, or
  `tee`.
- Do not use `cat` redirection to create, write, or overwrite files.

## Sandbox, Cache, and Install Directories

- Do not redirect caches, package stores, or tool installation homes
  with environment variables in order to work around sandbox
  restrictions.
- Avoid ad-hoc overrides such as `XDG_CACHE_HOME`, `CARGO_HOME`,
  `RUSTUP_HOME`, `npm_config_cache`, `PIP_CACHE_DIR`, `GOCACHE`,
  `GOMODCACHE`, `GOPATH`, or similar unless the task explicitly
  requires them.
- Prefer each tool's normal default cache and install directories. If
  the sandbox blocks the required path, request escalation instead of
  rerouting the tool into workspace-local directories, `.cache`
  subdirectories, `/tmp`, or other ad-hoc temporary locations.

## Verification Before Finish

- After code changes, run at least the smallest relevant verification
  command (build/test/lint subset).
- If verification cannot run, explicitly report what was not verified
  and why.
- When a recommended check is skipped, explicitly report the reason and
  run the closest available fallback.
- Markdown changes should prefer `rumdl`; run `rumdl fmt` first for
  auto-fixable issues, then `rumdl check`, and finish with manual
  cleanup for any remaining violations. If `rumdl` is unavailable
  locally, skip Markdown lint instead of substituting another linter.
- Shell scripts should comply with `shellcheck` guidance whenever
  feasible.
- Use the language-specific command matrix in `Minimal Acceptance
  Matrix` as the default operational checklist.

## Reliability Anti-Patterns

- Do not add fallback paths unless degradation behavior is explicitly
  defined and observable; silent fallback that hides errors is
  forbidden.
- Do not use broad `try/catch` blocks that swallow root causes; catch
  only where recovery is real, otherwise rethrow with context.
- Do not write tests that always pass by construction; each test must
  contain assertions that can fail for meaningful regressions.
- Do not hardcode constants, thresholds, or special branches solely to
  satisfy current tests; fix behavior, not test optics.
- For bug fixes, write a failing reproduction test first, then
  implement the fix, then verify the test passes.
- Do not remove diagnostic logs required for debugging or postmortem
  evidence during bug-fix work; reduce noise carefully and keep key
  traces.

## Task Naming and Entrypoints

- Use consistent task names where possible: `fmt`, `lint`, `typecheck`,
  `build`, `test`, and `check`.
- `check` should represent the smallest full quality gate
  (format/lint/type checks when applicable, build, and smallest
  relevant tests).
- For projects with task runners, prefer exposing these names directly
  (for example `justfile`, `Taskfile.yml`, `Makefile`, or package
  scripts).
- Preferred task entrypoint order: `just`, then `task`, then `make`,
  then language-native commands.

## Search and Automation Defaults

- Prefer `ast-grep` (`sg`) for structural code search.
- Prefer `rg` for text search and `rg --files` for file listing.
- Prefer `fd` for fast path/file discovery when suitable.
- Use `chrome-devtools` for direct web browsing and web automation when
  available.
- Use `agent-browser` as the fallback browser automation tool. Run
  `agent-browser --help` for full command reference.
- If neither external browser tool is available, use the built-in web
  browsing/search tools.
- Browser workflow default:
  - Prefer `chrome-devtools` navigation, snapshot, click, fill, and
    evaluate tools.
  - If `chrome-devtools` is unavailable, use
    `agent-browser open <url>`
  - Then use `agent-browser snapshot -i` for interactive refs (for
    example `@e1`, `@e2`)
  - Interact via refs (`agent-browser click @e1`,
    `agent-browser fill @e2 "text"`)
  - Re-run a snapshot after page changes.

## Script Authoring

- Do not use Node.js to write or execute long scripts.
- Prefer shell and Python for writing and executing long scripts.
- For scripts over roughly 80 lines, prefer storing them in a `scripts/`
  path instead of inline shell.
- Add brief usage notes at the top of long scripts (purpose, inputs,
  expected output).

## Git Hygiene

- Do not amend commits unless explicitly requested.
- Keep commits scoped to one concern and use Conventional Commit
  prefixes (`feat:`, `fix:`, `refactor:`, `chore:`, `docs:`).
- Do not revert user-authored changes unless explicitly requested.

## Language and Tooling Baselines

- Time-sensitive baselines (`latest unstable`, `latest LTS`, `latest
  stable`) must be verified at execution time.
- Rust: use latest unstable toolchain by default; if
  `rust-toolchain.toml` exists, it is source of truth.
- Go: require `1.26+`.
- Swift: require `6.x`.
- Node.js: use latest LTS.
- Python: require `3.13+`.
- PHP: require `8.x`.
- C#: follow repository `TargetFramework`; for new projects, use latest
  stable .NET release.

## Language Tooling Defaults

- Go: use `gofumpt` as default formatter.
- Python: prefer Astral tooling (`ruff`, `uv`, `ty`) when applicable.
- Python package management: do not use `pip` directly; use `uv` by
  default, `poetry` first fallback, traditional `venv` workflows second
  fallback.
- Node.js: prefer `pnpm` as default package manager.
- Lua: use `selene` as default linter.
- PHP: use Mago toolchain by default (`mago fmt`, `mago lint`,
  `mago analyze`).

## Type Safety and Return Values

- Default rule: in Go, TypeScript, and other static languages with
  `any`-like top types (`Any`, `Object`, `dynamic`, `mixed`), do not use
  them unless no practical typed alternative exists.
- TypeScript: prefer `unknown`, generics, discriminated unions, and
  explicit interfaces/types instead of `any`.
- Go: prefer concrete types, constrained interfaces, or type
  parameters instead of `any`/`interface{}`.
- Risk-tier policy for `any`-like types:
  - Core domain and security/permission/state-critical code: prohibited.
  - Application/service orchestration code: strongly discouraged; allow
    only with documented justification.
  - Boundary/adaptor code (deserialization, reflection, plugin/SDK
    bridges, external schema ingress): allowed with strict guards.
- Allowed boundary scenarios include:
  - Parsing unknown external payloads before validation.
  - Reflection/meta-programming surfaces required by framework/runtime.
  - Legacy migration shims with a removal plan.
- Required safeguards when `any`-like types are used:
  - Keep scope minimal; do not propagate across module boundaries.
  - Validate and narrow types immediately at the boundary.
  - Document why it is needed and the condition for later removal.
  - Do not introduce broad helper APIs that return/pass through raw
    `any`-like values by default.
- Enforcement strategy:
  - No new unreviewed `any`-like usage in changed files.
  - Prefer lint/typecheck rules that fail on new broad-type usage, with
    explicit allowlists for boundary paths when needed.
  - During refactors, prioritize "no new debt" first, then shrink
    existing broad-type hotspots incrementally.

## Zig Policy

- Toolchain baseline: use latest stable available locally; verify with
  `zig version`.
- Default build entrypoint: `zig build`.
- Zig workflow:
  - Verify local Zig version and CLI usage before writing Zig code.
  - Do not use removed or deprecated Zig APIs.
  - Official Zig documentation source:
    `https://ziglang.org/documentation/` (prefer version-matched docs;
    use `master` only when version-specific docs are unavailable).
  - Official Zig source/proposal source:
    `https://codeberg.org/ziglang/zig`.
  - Do not use Context7 for Zig docs/reference lookup; Zig entries are
    considered stale and unmaintained.
  - For any `std.*` usage, run `zig env` first to locate local Zig
    source, then verify symbol signatures/semantics in source before
    coding.
  - Do not implement `std` APIs from memory without source verification.
  - Zig source/proposal lookup is limited to Zig official sources and
    Codeberg; do not use GitHub as a Zig source/proposal reference.
  - After writing Zig code, compile locally and resolve errors before
    finalizing.
  - If compile/runtime errors occur, consult local Zig source/docs
    first, then revise.
- Error/optional handling policy:
  - `reader`/`writer` parameters must not use `anytype`.
  - For `reader`/`writer` parameters, use the proper Zig std I/O
    interface types for the active Zig version instead of generic
    `anytype`.
  - In non-test code, forbid empty handling patterns:
    `expr catch {}` and `expr orelse {}`.
  - In non-test code, forbid `expr catch unreachable` and
    `expr orelse unreachable`.
  - Non-test code must handle errors/optionals explicitly (propagate,
    transform, return, or assert with rationale).
  - In I/O code paths, do not silently swallow errors; every error must
    be propagated, translated with rationale, or returned.
  - Do not use `unreachable` as a substitute for recoverable I/O error
    handling in non-test code.
  - When translating I/O errors, document why the mapping is correct and
    what semantics are preserved.
- Ignore-value policy:
  - Do not ignore values just to silence compiler checks.
  - Prohibited examples include `_ = allocator;` and similar no-op
    discards used only to bypass diagnostics.
- No reimplementation policy:
  - If Zig `std` or Zig language syntax already provides the capability,
    do not rewrite or duplicate it.
  - Exceptions are allowed only with measured performance evidence or
    hard platform/compat constraints, and must be documented.
- Allocator policy:
  - Follow Zig official "Choosing an Allocator" guidance as the default
    decision process.
  - Tests should use `std.testing.allocator`; use
    `std.testing.FailingAllocator` when validating OOM handling.
  - Debug general-purpose allocation may use `std.heap.DebugAllocator`.
  - ReleaseFast general-purpose allocation should prefer
    `std.heap.smp_allocator`; do not enforce `page_allocator` as a
    universal release default.
- Cross-compilation preference: if no project-provided workflow exists
  and the project includes `build.zig` with target support, prefer
  Zig-based cross compilation.
- Acceptance for Zig changes: run `zig fmt` on touched files when
  applicable, then run the smallest relevant `zig build` or
  `zig build test` target.
- Return-value policy:
  - Do not ignore function or method return values to bypass checks.
  - Prohibited pattern: `_ = a.b();` (unless the discard is a documented
    test-only exception below).
  - Every return value must be handled explicitly (check, propagate,
    transform, or assert).
- Test-only relaxations (`test` blocks and `test` files/directories):
  - Rule relaxations are limited to handling and discard policies above:
    `catch/orelse unreachable` and `_ = ...` may be used only when
    justified.
  - `reader`/`writer` parameter typing rules still apply in tests; do
    not use `anytype` for them.
  - Every relaxation must include a short inline comment explaining why
    it is safe and test-scoped.
  - Source verification (`zig env` + local source check) and
    no-reimplementation policy remain mandatory in tests.

## Build Tool Defaults

- C/C++: use `CMake` with `Ninja` by default, and prefer preset-driven
  workflows.
- Rust: use `cargo` as default build/test/lint entrypoint.
- Go: use native `go` commands as default build/test entrypoint.
- Python: use `uv` as default environment and command runner.
- Node.js: use `pnpm` with `corepack` for package manager version
  pinning.
- Swift: use Swift Package Manager (`swift build`, `swift test`) by
  default.
- C#: use `dotnet` CLI as default build/test/format entrypoint.

## C/C++, CMake Defaults

- C/C++ preflight checks: `clang --version`, `clang-format --version`,
  and `clang-tidy --version`.
- Unless platform constraints require otherwise, use `C23` for C and
  `C++23` for C++.
- Prefer `clang` toolchain by default.
- Use `clang-format` for C/C++ formatting.
- Use `clang-tidy` for C/C++ static analysis.
- Prefer modern C++ style/idioms; avoid mixing C-style patterns into
  C++ unless compatibility requires it.
- Use `CMake 4.x` by default.
- Prefer modern CMake target-based patterns and explicit
  `PRIVATE/PUBLIC/INTERFACE`.
- Prefer CMake Presets when present:
  - `cmake --preset <cfg>`
  - `cmake --build --preset <build>`
  - `ctest --preset <test>`
  - `cpack --preset <pkg>`
  - `cmake --workflow --preset <wf>`
- Keep shared presets in `CMakePresets.json` (tracked) and local
  overrides in `CMakeUserPresets.json` (not tracked).
- Use `inherits`, `include`, and hidden base presets to avoid
  duplication.
- Use ad-hoc `-D` and generator arguments only for temporary debugging
  or one-off local experiments.

## Language Policy (C/C++ Focus)

- Keep C and C++ boundaries clear (C APIs in C code, RAII/STL patterns
  in C++).
- In new C++ code, avoid raw `malloc/free` unless compatibility
  boundaries require it.
- Use strict warning levels by default: `-Wall -Wextra -Wpedantic
  -Wconversion`, and tighten incrementally toward `-Werror` for
  controlled scopes.
- In C++, use `#pragma once` in new headers and keep include layering
  consistent.
- Keep error-handling strategy consistent within a module (C: return
  codes/enums; C++: one chosen pattern such as exceptions or
  `expected`).
- For C++ concurrency, prefer modern standard facilities
  (`std::jthread`, `std::stop_token`) where applicable.
- Require measurable before/after benchmark evidence for
  performance-oriented changes.
- Use C ABI boundaries (`extern "C"`) for cross-language interfaces and
  document ownership/alignment/encoding expectations.
- For C/C++ changes, provide at least one relevant test evidence type
  (unit/component/regression/benchmark as applicable).

## Cross Compilation Policy

- Prefer project-provided cross-compilation workflows first (documented
  scripts, presets, CI workflows, or toolchain files).
- If project-provided workflows are unavailable, use host-native cross
  toolchain approach:
  - On Gentoo, prefer `crossdev`.
  - On other systems, prefer platform-native cross toolchains and
    package workflows.
- If none of the above are available, use manual cross compilation with
  explicit toolchain configuration.
- Before cross-compiling, define and document target triple,
  architecture, ABI, libc/runtime, and minimum OS/runtime version.
- After cross-compiling, verify artifacts with binary inspection tools
  (`file`, `readelf`) and run the smallest feasible smoke test (use
  emulation such as `qemu` when needed).

## Minimal Acceptance Matrix

- C/C++ changes: run `clang-format` on touched files, run `clang-tidy`
  on touched files, build affected targets, then run the smallest
  relevant test subset.
- Rust changes: run `cargo fmt`, `cargo clippy`, build affected
  targets, then run the smallest relevant test subset.
- Go changes: run `gofumpt` on touched files, build affected packages,
  then run the smallest relevant test subset.
- Python changes: run `ruff` checks, run `ty` when configured, and run
  the smallest relevant test subset.
- Node.js changes: run the smallest relevant `pnpm`
  lint/typecheck/test subset, then build affected packages when
  applicable.
- Swift changes: run `swift build` and the smallest relevant `swift
  test` subset.
- Lua changes: run `selene` and the smallest relevant test or smoke
  subset.
- PHP changes: run `mago fmt --check`, `mago lint`, `mago analyze`,
  then run the smallest relevant test subset.
- C# changes: run `dotnet format --verify-no-changes`, build affected
  projects, then run the smallest relevant `dotnet test` subset.
- Script changes: run `shellcheck` when available and execute at least
  one smoke command.
- Markdown changes: run `rumdl fmt` on touched files when available,
  then `rumdl check`, then manually fix any remaining issues; otherwise
  skip Markdown lint.
