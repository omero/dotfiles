---
description: Create one or more atomic gitmoji commits, splitting unrelated changes
---
# Git commit

1. Inspect the repository root, `git status`, staged and unstaged changes against `HEAD`, the current branch, and the last 10 commits.
2. If nothing is staged, stage the relevant modified and new files using paths relative to the repository root.
3. If the changes mix unrelated concerns (different scopes, or feature versus fix versus chore), split them into separate atomic commits. Otherwise, create one commit.
4. For each commit, follow the Gitmoji specification:
   - Use an intention emoji from https://gitmoji.dev, in either Unicode or `:shortcode:` form. Match the format used by recent commits when there is an established convention.
   - Write the subject as `<intention> [scope?][:?] <message>`: the scope is optional contextual information; the message is a brief explanation of the change.
   - When using a scope, format it as `(scope)` and separate it from the message with `:` (for example, `♻️ (components): Transform classes to hooks`).
   - Without a scope, use the intention followed directly by the brief, present-tense imperative message (for example, `🐛 Fix onClick event handler`).

Never push, amend, modify files, or perform unrelated work. If there are no changes to commit or committing cannot proceed, explain why instead.
