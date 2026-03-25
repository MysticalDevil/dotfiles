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
- Use `agent-browser` for web automation. Run `agent-browser --help`
  for full command reference.
- Browser workflow default:
  - `agent-browser open <url>`
  - `agent-browser snapshot -i` for interactive refs (for example
    `@e1`, `@e2`)
  - Interact via refs (`agent-browser click @e1`,
    `agent-browser fill @e2 "text"`)
  - Re-run snapshot after page changes.

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
- Zig: use latest stable available locally; verify with `zig version`.
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
- Zig: use `zig build` as default build entrypoint.
- C#: use `dotnet` CLI as default build/test/format entrypoint.

## C/C++, CMake, and Zig Defaults

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
- Zig workflow:
  - Verify local Zig version and CLI usage before writing Zig code.
  - Do not use removed or deprecated Zig APIs.
  - Verify APIs against local Zig version/docs/source instead of memory.
  - After writing Zig code, compile locally and resolve errors before
    finalizing.
  - If compile/runtime errors occur, consult local Zig source/docs
    first, then revise.

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
- If no project-provided workflow exists and the project includes a
  `build.zig` with target support, prefer Zig-based cross compilation.
- If Zig-based cross compilation is unavailable, use host-native cross
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
- Zig changes: run `zig fmt` on touched files when applicable, then run
  the smallest relevant `zig build` or `zig build test` target.
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
