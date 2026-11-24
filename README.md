# Dotfiles

Each directory is a [GNU Stow](https://www.gnu.org/software/stow/) package that links into `$HOME`.
The `setup` mise task links the packages for the current OS.

| OS | Packages |
|---|---|
| All | `agents` `claude` `git` `mise` `pi` `starship` |
| Linux (Omarchy) | `bash` `gnupg` `hypr` |
| macOS | `gnupg-macos` `mise-macos` `zsh` |

`setup` runs `stow --no-folding`, so stow links files and never whole directories.
This keeps runtime files, such as the private files in `~/.gnupg`, out of the repository.

## Requirements

- Linux: Omarchy. It provides `mise`, `stow`, and the agent CLIs.
- macOS: Homebrew and mise.

## Install

```bash
git clone https://github.com/omero/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
mise trust
mise run brew   # macOS only
mise run setup -- -n
mise run setup
mise install
```

- `mise run setup -- -n` runs `stow` in simulation mode and shows conflicts.
- `mise run brew` runs `brew bundle` with the `Brewfile`. It is connected to the terminal, so you can type the `sudo` password that some casks ask for.
- `mise install` skips `lazy` tools. mise installs them on first use.

## YubiKey on a new machine

Import the public key and read the connected YubiKey:

```bash
curl -fsSL https://github.com/omero.gpg | gpg --import
gpg --card-status
```

On macOS, `mise run brew` installs `gnupg` and `pinentry-mac`.
`gnupg-macos` sets `pinentry-program` to `/opt/homebrew/bin/pinentry-mac` (Apple Silicon path).

## Switch the remote to SSH

Clone with HTTPS because SSH needs the GnuPG config, the shell config, and the imported public key.
SSH uses the authentication subkey on the YubiKey through `gpg-agent`.
After `setup`, open a new terminal and run:

```bash
gpg --card-status
ssh -T git@github.com
git -C ~/.dotfiles remote set-url origin git@github.com:omero/dotfiles.git
```

## Conflicts

`stow` stops when a target is a regular file and not a link.
This happens on a new machine, or when an app saves its config over the link.

1. Compare the files: `diff ~/.dotfiles/<package>/<path> ~/<path>`.
2. Keep the local file: `stow --adopt -t "$HOME" <package>`, then review `git diff`.
3. Keep the repository file: delete the local file and run `mise run setup`.

## mise tools

| File | Scope |
|---|---|
| `mise/.config/mise/config.toml` | All machines |
| `mise-macos/.config/mise/conf.d/macos.toml` | macOS only: agent CLIs that Omarchy provides on Linux |

Omarchy defines the agent CLIs in `/etc/mise/conf.d/omarchy-tools.toml`.
Do not add them to the global config. A global entry replaces the Omarchy entry on Linux.
Copy option changes from Omarchy into `macos.toml` by hand:

```bash
grep -E '^(claude|pi|codex) ' /etc/mise/conf.d/omarchy-tools.toml
```

## Commit signing

Git signs with the primary key.
Each YubiKey holds its own signing subkey.
After you change the YubiKey, run `gpg --card-status` once so gpg uses the connected card.
