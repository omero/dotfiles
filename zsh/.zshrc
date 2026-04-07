# post brew config
eval "$(/opt/homebrew/bin/brew shellenv)"

# Starship prompt
eval "$(starship init zsh)"
# Smart directory navigation
eval "$(zoxide init zsh)"
# Auto-load environment variables per directory
eval "$(direnv hook zsh)"
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
alias g="git"
alias cd="z"
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(mise activate zsh)"

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

# gcp
# The next line updates PATH for the Google Cloud SDK.
# Get gcloud installation path
GCLOUD_PATH=$(asdf where gcloud 2>/dev/null)
COMPLETION_STATUS=$?

if [ $COMPLETION_STATUS -eq 0 ] && [ -n "$GCLOUD_PATH" ]; then
  # Build the completion file path
  source "$GCLOUD_PATH/completion.zsh.inc"
  source "$GCLOUD_PATH/path.zsh.inc"  
else
  log_message "Error: gcloud is not installed via asdf"
  log_message "Please install it using: asdf plugin add gcloud && asdf install gcloud latest"
fi

export PATH=${PATH}:${HOME}/.bin
export PATH=${PATH}:${HOME}/.local/bin

export USE_GKE_GCLOUD_AUTH_PLUGIN=true

# Visual Studio Code
alias code="open $1 -a 'Visual Studio Code'"


