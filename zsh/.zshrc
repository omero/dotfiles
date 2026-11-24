# post brew config
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(/Users/omers/.local/bin/mise activate zsh)"

# Starship prompt
eval "$(starship init zsh)"
# Smart directory navigation
eval "$(zoxide init zsh)"
# Zsh plugins
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# vim / nvim aliases
export EDITOR=nvim
# Aliases
alias ls="eza --icons"
alias ll="eza -la --icons"
alias tree="eza --tree --icons"
alias vim="nvim"
alias n="nvim"
alias g="git"
alias cd="z"
alias ..='cd ..'
alias ...='cd ../..'
alias ff="fzf --preview 'bat --style=numbers --color=always -- {}'"

eff() {
  local file
  file=$(ff) && [[ -n "$file" ]] && "$EDITOR" -- "$file"
}

# fzf
source <(fzf --zsh)

# ssh agent to use gpg
eval $(ssh-agent)
if [ ! -n "$SSH_CLIENT" ]; then
  gpgconf --launch gpg-agent

  if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  fi

  GPG_TTY=$(tty)
  export GPG_TTY
  # only necessary if using pinentry in the tty (instead of GUI)
  echo UPDATESTARTUPTTY | gpg-connect-agent > /dev/null 2>&1
fi


# ZSH Facts
HISTFILE=${HOME}/.zsh_history
HISTSIZE=20000
SAVEHIST=${HISTSIZE}
COMPLETION_WAITING_DOTS=true
setopt extended_history
setopt hist_expire_dups_first
setopt inc_append_history
# autocompletion using arrow keys (based on history)
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

