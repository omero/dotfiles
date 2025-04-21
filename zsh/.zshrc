# post brew config
eval "$(/opt/homebrew/bin/brew shellenv)"

# brew completions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

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

# oh my posh
# eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/config.toml)"

#starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"
alias cd="z"

# vim / nvim aliases
export EDITOR=nvim
alias vim="nvim"
alias vi="nvim"
alias oldvim="vim"

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

# zsh plugins
source ${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# direnv
eval "$(direnv hook zsh)"

# alias exa 
alias ls="eza --icons --group-directories-first --time-style=long-iso --git"
alias tree="eza --tree --icons"

#asdf
#
export ASDF_DATA_DIR="/Users/omers/.asdf"
export PATH="$ASDF_DATA_DIR/shims:$PATH"

autoload -Uz compinit && compinit

#golang
. ~/.asdf/plugins/golang/set-env.zsh


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

# yazi 
function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

alias v="open $1 -a 'Visual Studio Code'"

# Lando
export PATH="/Users/omers/.lando/bin${PATH+:$PATH}"; #landopath

# pnpm
export PNPM_HOME="/Users/omers/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

