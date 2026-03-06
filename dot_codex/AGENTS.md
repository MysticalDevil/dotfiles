# Global Agent Rules

## Instruction Hierarchy
- Apply instructions in this order unless the user explicitly overrides for the current task: global rules, repository rules, then temporary task-specific instructions.
- If two instructions conflict, follow the higher-precedence source and state the conflict briefly.
- Unless the user explicitly requests otherwise, follow these defaults.
- Tooling required by existing project dependencies is allowed even when a language/runtime is discouraged for new script authoring.

## Tooling Priorities
- Prefer built-in tools for file reads and writes whenever available.
- For file edits, prefer built-in edit tools (especially `apply_patch`) over shell-based edits.
- For file reads, prefer built-in resource/read tools when available; otherwise use minimal shell read commands.
- Avoid using `bat`/`cat` when a built-in tool can do the same job.
- Use `bat`/`cat` only as read-only fallbacks when built-in tools are unavailable.
- Do not use `cat` redirection to create, write, or overwrite files.
- Prefer `ast-grep` (`sg`) for structural code search.
- Prefer `rg` for text search and `rg --files` for file listing.
- Prefer `fd` for fast path/file discovery when suitable.
- Do not use Node.js to write or execute long scripts.
- Prefer shell and Python for writing and executing long scripts.

## Browser Automation
- Use `agent-browser` for web automation. Run `agent-browser --help` for all commands.
- Core workflow:
  - `agent-browser open <url>` to navigate to a page.
  - `agent-browser snapshot -i` to get interactive elements with refs (for example `@e1`, `@e2`).
  - Use refs for interactions, such as `agent-browser click @e1` and `agent-browser fill @e2 "text"`.
  - Re-run snapshot after page changes before continuing interactions.

## Execution Safety
- Ask for confirmation before destructive operations such as `rm -rf`, `git reset --hard`, or `git checkout --`.
- When supported, run a `--dry-run` first before destructive or bulk operations.
- Do not modify unrelated files unless explicitly requested.

## Editing Rules
- Prefer `apply_patch` for single-file edits.
- Do not write files using shell redirection (`>`, `>>`), heredoc, or `tee`; use patch-based edits/tools.
- Keep edits minimal, scoped, and reversible.

## Git Hygiene
- Do not amend commits unless explicitly requested.
- Keep commits scoped to one concern and use Conventional Commit prefixes (`feat:`, `fix:`, `refactor:`, `chore:`, `docs:`).
- Do not revert user-authored changes unless explicitly requested.

## Validation Before Finish
- After code changes, run at least the smallest relevant verification command (build/test/lint subset).
- If verification cannot run, explicitly report what was not verified and why.
- Markdown changes should comply with the DavidAnson Markdown rule set whenever feasible.
- Shell scripts should comply with `shellcheck` guidance whenever feasible.
- When a recommended check is skipped, explicitly report the reason and run the closest available fallback.

## Preflight Checks
- For C/C++ tasks, check local toolchain availability first: `clang --version`, `clang-format --version`, and `clang-tidy --version`.
- For Zig tasks, follow the preflight checks defined in `Zig Workflow`.

## Script Guidelines
- For scripts over roughly 80 lines, prefer storing them in a `scripts/` path instead of inline shell.
- Add brief usage notes at the top of long scripts (purpose, inputs, and expected output).

## Zig Workflow
- When asked to write Zig code, first confirm the installed Zig version and current CLI usage via local `zig` commands.
- Do not use removed or deprecated Zig APIs.
- Do not rely on memory when writing Zig code; verify APIs against the local installed Zig version and local docs/source first.
- After writing Zig code, compile it locally and resolve all errors before finalizing.
- If compile/runtime errors occur, consult local Zig source code and local Zig documentation first, then revise code accordingly.

## C/C++ and CMake Defaults
- Unless platform constraints require otherwise, use `C23` for C code.
- Unless platform constraints require otherwise, use `C++23` for C++ code.
- Prefer the `clang` toolchain for C/C++ by default.
- Use `clang-format` for C/C++ formatting.
- Use `clang-tidy` for C/C++ static analysis.
- Prefer modern C++ style and idioms whenever possible.
- Avoid mixing C-style patterns into C++ unless required for compatibility.
- Use `CMake 4.x` by default.
- Prefer modern CMake patterns, targets, and syntax whenever possible.
- Prefer CMake Presets as the default workflow in CMake 4.x projects.
- Keep shared presets in `CMakePresets.json` (tracked) and local developer overrides in `CMakeUserPresets.json` (not tracked).
- Prefer preset-driven commands when presets exist: `cmake --preset <cfg>`, `cmake --build --preset <build>`, `ctest --preset <test>`, `cpack --preset <pkg>`, and `cmake --workflow --preset <wf>`.
- Use `inherits`, `include`, and hidden base presets to avoid duplicated preset definitions.
- Use ad-hoc command-line `-D` and generator arguments only for temporary debugging or one-off local experiments.

## Language Version Baselines
- Rust: use the latest unstable toolchain by default.
- Rust: when a repository includes `rust-toolchain.toml`, it is the source of truth and must be followed.
- Go: require `1.26+`.
- Swift: require `6.x`.
- Zig: use the latest stable release available locally; verify with `zig version`.
- Node.js: use the latest LTS release.
- Python: require `3.13+`.
- PHP: require `8.x`.
- C#: follow the repository `TargetFramework`; for new projects, use the latest stable .NET release.

## Language Tooling Defaults
- Go: use `gofumpt` as the default formatter.
- Python: default to Astral tooling (`ruff`, `uv`, and `ty`) when applicable.
- Python package management: do not use `pip` directly; use `uv` by default, with `poetry` as the first fallback and traditional `venv` workflows as the second fallback.
- Node.js: prefer `pnpm` as the default package manager.
- Lua: use `selene` as the default linter.
- PHP: use the Mago toolchain by default (`mago fmt`, `mago lint`, and `mago analyze`).
- Time-sensitive baselines such as `latest unstable`, `latest LTS`, and `latest stable` must be verified at execution time.

## Build Tool Defaults
- C/C++: use `CMake` with the `Ninja` generator by default, and prefer preset-driven workflows.
- Rust: use `cargo` as the default build/test/lint entrypoint.
- Go: use native `go` commands as the default build/test entrypoint.
- Python: use `uv` as the default environment and command runner.
- Node.js: use `pnpm` with `corepack` for package manager version pinning.
- Swift: use Swift Package Manager (`swift build`, `swift test`) by default.
- Zig: use `zig build` as the default build entrypoint.
- C#: use `dotnet` CLI as the default build/test/format entrypoint.

## Cross Compilation Policy
- Prefer project-provided cross-compilation workflows first (for example documented scripts, presets, CI workflows, or toolchain files). If available, use them directly.
- If no project-provided workflow exists, and the project includes a `build.zig` with target support, prefer Zig-based cross compilation.
- If Zig-based cross compilation is not available, use the host-native cross toolchain approach:
  - On Gentoo, prefer `crossdev`.
  - On other systems, prefer the platform-native cross toolchains and package workflow.
- If none of the above are available, use traditional manual cross compilation with explicit toolchain configuration.
- Before cross-compiling, define and document the target triple, architecture, ABI, libc/runtime, and minimum OS/runtime version.
- After cross-compiling, verify artifacts with binary inspection tools (for example `file`, `readelf`) and run the smallest feasible smoke test (use emulation such as `qemu` when needed).

## Unified Task Naming
- Use consistent task names across languages where possible: `fmt`, `lint`, `typecheck`, `build`, `test`, and `check`.
- `check` should represent the smallest full quality gate for a change (format, lint, type checks when applicable, build, and the smallest relevant test subset).
- For projects with task runners, prefer exposing these names directly (for example in `justfile`, `Taskfile.yml`, `Makefile`, or package scripts).
- Preferred task entrypoint order: `just`, then `task`, then `make`, then language-native commands.

## Language Policy
- Keep C and C++ boundaries clear: use C APIs in C code and RAII/STL patterns in C++ code.
- In new C++ code, avoid raw `malloc/free` unless required by compatibility boundaries.
- Use strict warning levels by default (`-Wall -Wextra -Wpedantic -Wconversion`) and tighten incrementally toward `-Werror` for controlled scopes.
- In C++, use `#pragma once` in new headers and keep include layering consistent.
- Keep error-handling strategy consistent within a module (C: return codes/enums; C++: one chosen pattern such as exceptions or `expected`).
- For C++ concurrency, prefer modern standard facilities (`std::jthread`, `std::stop_token`) where applicable.
- Require measurable before/after benchmark evidence for performance-oriented changes.
- Use C ABI boundaries (`extern "C"`) for cross-language interfaces and document ownership/alignment/encoding expectations.
- In CMake, prefer target-scoped commands (`target_*`) and explicit `PRIVATE/PUBLIC/INTERFACE` visibility.
- For C/C++ changes, provide at least one relevant test evidence type (unit/component/regression benchmark as applicable).

## Minimal Acceptance Matrix
- C/C++ changes: run `clang-format` on touched files, run `clang-tidy` on touched files, build affected targets, then run the smallest relevant test subset.
- Rust changes: run `cargo fmt`, `cargo clippy`, build affected targets, then run the smallest relevant test subset.
- Go changes: run `gofumpt` on touched files, build affected packages, then run the smallest relevant test subset.
- Python changes: run `ruff` checks, run `ty` when configured, and run the smallest relevant test subset.
- Node.js changes: run the smallest relevant `pnpm` lint/typecheck/test subset, then build affected packages when applicable.
- Swift changes: run `swift build` and the smallest relevant `swift test` subset.
- Zig changes: run `zig fmt` on touched files when applicable, then run the smallest relevant `zig build` or `zig build test` target.
- Lua changes: run `selene` and the smallest relevant test or smoke subset.
- PHP changes: run `mago fmt --check`, `mago lint`, `mago analyze`, then run the smallest relevant test subset.
- C# changes: run `dotnet format --verify-no-changes`, build affected projects, then run the smallest relevant `dotnet test` subset.
- Script changes: run `shellcheck` when available and execute at least one smoke command.
- Markdown changes: keep touched files aligned with the DavidAnson Markdown rule set whenever feasible.
