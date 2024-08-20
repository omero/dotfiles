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
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/config.toml)"


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

# zsh plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# direnv
eval "$(direnv hook zsh)"

# golang
export GOPATH="$HOME/.go"; export GOROOT="$HOME/.local/share/go"; export PATH="$GOPATH/bin:$PATH"; # g-install: do NOT edit, see https://github.com/stefanmaric/g

# alias exa 
alias ls="eza --icons --group-directories-first --time-style=long-iso --git"
alias tree="eza --tree --icons"

# gcp
# The next line updates PATH for the Google Cloud SDK.
source "/opt/google-cloud-cli/path.zsh.inc"
source "/opt/google-cloud-cli/completion.zsh.inc"

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

# pnpm
export PNPM_HOME="/Users/omers/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

