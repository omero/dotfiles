# Working Preferences

- Use simple explanations for your responses
- Prefer simple, incremental changes over broad rewrites.
- Inspect the existing code and repository conventions before editing.
- Do not introduce abstractions without a concrete current need.
- State assumptions when material requirements are ambiguous.
- Run the smallest relevant validation after making changes.
- Before finishing, review the diff and report the checks performed.
- Do not make unrelated changes.
- Keep responses concise and show changed file paths clearly.

# Git 

- Keep commit messages short and concrete
- Do not add any co-authored information of Claude in commits or PRs.

# Worktrees

- Before creating a branch, ask whether the work is a `feat`, `fix`, `refactor`, `experiment` or `proposal`.
- Name branches `<type>/<short-description>`, without any tool-added prefix (e.g. `t3code/`, `codex/`, `claude/`).
- When creating a worktree, pass that name as the `branch` parameter.
