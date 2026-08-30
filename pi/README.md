# Pi configuration

This Stow package manages the portable, user-authored Pi configuration.
Runtime state and credentials under `~/.pi/agent` are intentionally not tracked.

## Install

From the dotfiles repository:

```bash
stow -t "$HOME" pi
```

Install the global workflow skills separately instead of vendoring them:

```bash
npx skills@latest add mattpocock/skills \
  --global \
  --agent pi \
  --skill grilling diagnosing-bugs handoff \
  --yes
```

Run `/reload` in an existing Pi session after changing these files.
