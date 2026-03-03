# Global Agent Rules

## Instruction Hierarchy
- Apply instructions in this order unless the user explicitly overrides for the current task: global rules, repository rules, then temporary task-specific instructions.
- If two instructions conflict, follow the higher-precedence source and state the conflict briefly.
- Unless the user explicitly requests otherwise, follow these defaults.
- Tooling required by existing project dependencies is allowed even when a language/runtime is discouraged for new script authoring.

## Tooling Priorities
- Prefer `bat` for file viewing.
- Use `cat` only as a read-only fallback.
- Do not use `cat` redirection to create, write, or overwrite files.
- Prefer `ast-grep` (`sg`) for structural code search.
- Prefer `rg` for text search and `rg --files` for file listing.
- Prefer `fd` for fast path/file discovery when suitable.
- Do not use Node.js to write or execute long scripts.
- Prefer shell and Python for writing and executing long scripts.

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

## Preflight Checks
- For C/C++ tasks, check local toolchain availability first: `clang --version`, `clang-format --version`, and `clang-tidy --version`.
- For Zig tasks, check local Zig version and CLI usage first: `zig version` and `zig help`.

## Script Guidelines
- For scripts over roughly 80 lines, prefer storing them in a `scripts/` path instead of inline shell.
- Add brief usage notes at the top of long scripts (purpose, inputs, and expected output).

## Zig Workflow
- When asked to write Zig code, first confirm the installed Zig version and current CLI usage via local `zig` commands.
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
- Go: require `1.26+`.
- Swift: require `6.x`.
- Zig: use the latest stable release available locally; verify with `zig version`.
- Node.js: use the latest LTS release.
- Python: require `3.13+`.

## Language Tooling Defaults
- Go: use `gofumpt` as the default formatter.
- Python: default to Astral tooling (`ruff`, `uv`, and `ty`) when applicable.
- Node.js: prefer `pnpm` as the default package manager.
- Time-sensitive baselines such as `latest unstable`, `latest LTS`, and `latest stable` must be verified at execution time.

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
- Script changes: run `shellcheck` when available and execute at least one smoke command.
- Markdown changes: keep touched files aligned with the DavidAnson Markdown rule set whenever feasible.
