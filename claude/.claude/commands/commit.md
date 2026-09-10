---
allowed-tools: Bash(git rev-parse:*), Bash(git -C * status:*), Bash(git -C * diff:*), Bash(git -C * log:*), Bash(git -C * branch:*), Bash(git -C * add:*), Bash(git -C * commit:*), Bash(pnpm --dir * check:*)
description: Create one or more atomic gitmoji commits, splitting unrelated changes
---

# Git commit slash command

## Context

- repo root: !`git rev-parse --show-toplevel`
- git status: !`git -C "$(git rev-parse --show-toplevel)" status`
- diff (staged + unstaged): !`git -C "$(git rev-parse --show-toplevel)" diff HEAD`
- recent commits: !`git -C "$(git rev-parse --show-toplevel)" log --oneline -10`
- current branch: !`git -C "$(git rev-parse --show-toplevel)" branch --show-current`

## Task

- If nothing is staged, stage the relevant modified/new files (paths relative to repo root, not cwd).
- If the diff mixes unrelated concerns (different scopes, or feature vs fix vs chore), split into multiple commits: stage and commit each group separately rather than one mixed commit.
- For each commit, pick the gitmoji per <https://gitmoji.dev> matching the change, write the subject in present-tense imperative, and commit.
- Never push.

Only use the tools listed above — no exploring beyond the provided context.
