# Working Preferences

## General

- Prefer simple, incremental changes over broad rewrites.
- Inspect the existing code and repository conventions before editing.
- Do not introduce abstractions without a concrete current need.
- State assumptions when material requirements are ambiguous.
- Run the smallest relevant validation after making changes.
- Do not make unrelated changes.
- Describe the current state, not refactor history. When renaming, replacing, or removing code, remove obsolete references from source, comments, documentation, metadata, demos, tests, and generated artifacts. Do not retain previous names, replacement narratives, migration notes, compatibility aliases, or tests whose sole purpose is asserting that an old implementation is absent unless I explicitly request them. Before finishing, search for obsolete names and historical wording. Leave history in Git; do not rewrite it.
- Avoid code comments at all cost unless is explicitly request, the code is the comment itself

## Communication

- Use simple explanations for your responses
- Keep responses concise and show changed file paths clearly.
- Before finishing, review the diff and report the checks performed.

Write all responses, plans, summaries, commit messages, and PR text in ASD-STE100 Simplified Technical English.

- Use the active voice. Use the imperative for instructions.
- Use simple tenses. Write "I changed the file", not "I have changed the file".
- Write one instruction or one idea in each sentence.
- Write a maximum of 20 words in an instruction and 25 words in a description.
- Write a maximum of 6 sentences in a paragraph, with one topic.
- Use a list for 3 or more steps or conditions.
- Do not use semicolons, contractions, or phrasal verbs. Write "start", not "spin up".
- Use one name for one item. Do not change between synonyms.
- Use the verb for an action. Write "analyze the log", not "do an analysis of the log".
- Keep articles, subjects, and verbs. Do not remove words to make a sentence short.
- Keep noun clusters to a maximum of 3 words.
- Keep the strength of each claim. If you are not sure, say so. Do not change "may have failed" to "failed".
- Do not apply these rules to code, commands, file paths, identifiers, or quoted text.
- For commit subjects, follow the commit prompt format. Articles are optional.

## Git

- Keep commit messages short and concrete
- Do not add any co-authored information of Claude in commits or PRs.

## Worktrees

- Before creating a branch, ask whether the work is a `feat`, `fix`, `refactor`, `experiment` or `proposal`.
- Name branches `<type>/<short-description>`, without any tool-added prefix (e.g. `t3code/`, `codex/`, `claude/`).
- When creating a worktree, pass that name as the `branch` parameter.
