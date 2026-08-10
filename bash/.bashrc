# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap
source "$OMARCHY_PATH/default/bash/rc"

# Aliases
# ls/cd/g are left to Omarchy's defaults (eza -lh --group-directories-first,
# the smarter zd() cd wrapper, and git) - only add what Omarchy doesn't cover.
alias ll="eza -la --icons"
alias tree="eza --tree --icons"
alias vim="nvim"

# History size/file size stay at Omarchy's defaults (32768); only the dedup
# behavior is overridden - erasedups keeps history fully deduplicated on top
# of Omarchy's ignoreboth (ignoredups + ignorespace).
HISTCONTROL=ignoreboth:erasedups

# SSH over the GPG agent's ssh-agent emulation (gpg-agent-ssh.socket is
# already socket-activated by systemd; Omarchy never points SSH_AUTH_SOCK at
# it). Skip when SSH_CLIENT is set so agent forwarding isn't clobbered.
if [ -z "$SSH_CLIENT" ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  export GPG_TTY="$(tty)"
fi
