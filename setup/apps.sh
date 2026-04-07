#!/bin/bash

# =============================================================================
# apps.sh — Homebrew packages, casks and Dock configuration (idempotent)
# Compatible with macOS Tahoe (16) and later
# =============================================================================

set -e

# =============================================================================
# Helpers
# =============================================================================

# Install a Homebrew CLI package only if not already installed
install_brew() {
  if ! brew list "$1" &>/dev/null; then
    echo "  ✅ Installing $1..."
    brew install "$1"
  else
    echo "  ⏭️  $1 already installed"
  fi
}

# Install a Homebrew cask only if not already installed
install_cask() {
  if ! brew list --cask "$1" &>/dev/null; then
    echo "  ✅ Installing $1..."
    brew install --cask "$1"
  else
    echo "  ⏭️  $1 already installed"
  fi
}

# =============================================================================
# Homebrew
# =============================================================================
echo ""
echo "🍺 Checking Homebrew..."
if ! command -v brew &>/dev/null; then
  echo "  ✅ Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add Homebrew to PATH (Apple Silicon)
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "  ⏭️  Homebrew already installed, updating..."
  brew update
fi

# =============================================================================
# CLI Packages
# =============================================================================
echo ""
echo "⚡ Installing CLI packages..."

CLI_PACKAGES=(
  anomalyco/tap/opencode # Open-source AI coding agent for the terminal
  ddev/ddev/ddev         # Local development environment for PHP projects
  direnv                 # Auto-load environment variables per directory
  eza                    # Modern replacement for ls
  fastfetch              # System info display for the terminal
  fd                     # Modern replacement for find
  fzf                    # Fuzzy finder for terminal
  gh                     # Official GitHub CLI
  git                    # Version control
  gitmoji                # Emoji standard for commit messages
  go-task/tap/go-task    # Modern alternative to make for running tasks
  gpg                    # Encryption and commit signing
  jq                     # JSON processor for the terminal
  lazydocker             # TUI for managing Docker
  lazygit                # TUI for managing Git
  neovim                 # Terminal text editor
  openssl                # Encryption library
  pinentry-mac           # GPG passphrase entry via macOS keychain
  mise                   # Runtime version manager (node, python, go, etc.)
  ripgrep                # Ultrafast text search (better grep)
  starship               # Fast and modern shell prompt
  stow                   # Manage dotfiles with symlinks
  tldr                   # Simplified man pages with practical examples
  tmux                   # Terminal multiplexer (multiple panes and sessions)
  unar                   # Extract almost any archive format via CLI
  wget                   # Download files from the terminal
  ykman                  # Manage YubiKey from the terminal (SSH, GPG, 2FA)
  yq                     # Like jq but for YAML
  zoxide                 # Smart directory navigation (cd replacement)
  zsh-autosuggestions    # Command suggestions as you type
  zsh-syntax-highlighting # Syntax highlighting for commands in real time
)

for pkg in "${CLI_PACKAGES[@]}"; do
  # Strip inline comment to get the actual package name
  name="${pkg%%#*}"
  name="${name%% }"
  install_brew "$name"
done

# =============================================================================
# GUI Apps (Casks)
# =============================================================================
echo ""
echo "🖥️  Installing GUI apps..."

CASK_APPS=(
  appcleaner         # Uninstall apps along with all their leftover files
  bambu-studio       # Slicer for Bambu Lab 3D printers
  devtoys            # Developer toolbox (encode, diff, JSON, etc.)
  discord            # Voice and text communication
  elgato-stream-deck # Stream Deck controller software
  figma              # UI and product design
  ghostty            # Fast and modern terminal emulator
  monitorcontrol     # Control external monitor brightness from macOS
  mutedeck           # Mute control for calls via Stream Deck
  ngrok              # Expose local ports to the internet
  nordvpn            # VPN client
  obsidian           # Notes and knowledge management
  ollama             # Run AI models locally
  orbstack           # Lightweight Docker Desktop alternative
  postman            # API testing and documentation
  rectangle          # Window management with keyboard shortcuts
  sequel-ace         # MySQL/MariaDB database client
  shottr             # Advanced screenshot tool
  slack              # Team communication
  spotify            # Music streaming
  the-unarchiver     # Extract archives via double-click in Finder
  transmit           # FTP/SFTP/S3 file transfer client
  ungoogled-chromium # Chromium browser without Google integration
  claude             # Anthropic's official Claude AI desktop app
  claude-code        # Terminal-based AI coding assistant
  visual-studio-code # Code editor
  vlc                # Video player
  zed                # Fast and modern code editor
  zoom               # Video calls
)

for app in "${CASK_APPS[@]}"; do
  name="${app%%#*}"
  name="${name%% }"
  install_cask "$name"
done

# =============================================================================
# Fonts
# =============================================================================
echo ""
echo "🔤 Installing fonts..."
install_cask "font-fira-code-nerd-font"    # Fira Code with Nerd Font icons
install_cask "font-monaspace-nerd-font"    # GitHub's Monaspace with Nerd Font icons

# =============================================================================
# Dock
# =============================================================================
echo ""
echo "🚀 Configuring Dock..."

# Install dockutil if not present
install_brew "dockutil"

# Remove all existing Dock items to start fresh
echo "  Clearing Dock..."
dockutil --remove all --no-restart

# Add apps in order — this defines the exact Dock layout
dockutil --add "/Applications/Safari.app"                     --no-restart
dockutil --add "/System/Applications/System Settings.app"     --no-restart
dockutil --add "/System/Applications/Notes.app"               --no-restart
dockutil --add "/System/Applications/iPhone Mirroring.app"    --no-restart
dockutil --add "/Applications/Visual Studio Code.app"         --no-restart
dockutil --add "/Applications/Ghostty.app"                    --no-restart
dockutil --add "/Applications/Spotify.app"                    --no-restart
dockutil --add "/Applications/Obsidian.app"                   --no-restart

echo "  ✅ Dock configured"

# Restart Dock to apply changes
killall Dock 2>/dev/null || true

# =============================================================================
# Zsh configuration
# =============================================================================
echo ""
echo "🐚 Configuring Zsh..."

# Helper to add a line to .zshrc only if it's not already there
add_to_zshrc() {
  grep -qF "$1" ~/.zshrc 2>/dev/null || echo "$1" >> ~/.zshrc
}

add_to_zshrc '# Starship prompt'
add_to_zshrc 'eval "$(starship init zsh)"'

add_to_zshrc '# Smart directory navigation'
add_to_zshrc 'eval "$(zoxide init zsh)"'

add_to_zshrc '# Auto-load environment variables per directory'
add_to_zshrc 'eval "$(direnv hook zsh)"'

add_to_zshrc '# Zsh plugins'
add_to_zshrc 'source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh'
add_to_zshrc 'source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'

add_to_zshrc '# Aliases'
add_to_zshrc 'alias ls="eza --icons"'
add_to_zshrc 'alias ll="eza -la --icons"'
add_to_zshrc 'alias vim="nvim"'
add_to_zshrc 'alias g="git"'
add_to_zshrc 'alias cd="z"'

add_to_zshrc '# fzf'
add_to_zshrc '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh'

# Initialize fzf keybindings if not already done
if [ ! -f ~/.fzf.zsh ]; then
  echo "  ✅ Initializing fzf..."
  "$(brew --prefix)/opt/fzf/install" --all --no-bash --no-fish
else
  echo "  ⏭️  fzf already initialized"
fi

echo "  ✅ Zsh configured"

# =============================================================================
# Done
# =============================================================================
echo ""
echo "✅ apps.sh complete"
echo ""
echo "📌 Manual steps required:"
echo "  - Restart the terminal to apply Zsh changes"
echo "  - Sign in to GitHub CLI:  gh auth login"
echo "  - Import your GPG key or generate a new one"
echo "  - Configure your YubiKey:  ykman info"
