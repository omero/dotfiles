#!/bin/bash

# =============================================================================
# dev.sh — Development environment setup (idempotent)
# Compatible with macOS Tahoe (16) and later
# =============================================================================

set -e

# =============================================================================
# Helpers
# =============================================================================

# Install a mise runtime only if not already installed
install_mise() {
  local tool=$1 version=$2
  if ! mise list "$tool" 2>/dev/null | grep -q "$version"; then
    echo "  ✅ Installing $tool@$version..."
    mise install "$tool@$version"
    mise use --global "$tool@$version"
  else
    echo "  ⏭️  $tool@$version already installed"
  fi
}

# =============================================================================
# mise
# =============================================================================
echo ""
echo "🔧 Checking mise..."
if ! command -v mise &>/dev/null; then
  echo "  ⚠️  mise is not installed — run apps.sh first"
  exit 1
fi

# Activate mise in zsh if not already configured
if ! grep -qF 'mise activate zsh' ~/.zshrc 2>/dev/null; then
  echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
  echo "  ✅ mise activated in .zshrc"
else
  echo "  ⏭️  mise already activated in .zshrc"
fi

# =============================================================================
# Runtimes
# =============================================================================
echo ""
echo "⚡ Installing runtimes..."

install_mise "node"   "lts"
install_mise "python" "latest"
install_mise "go"     "latest"

# =============================================================================
# Package managers
# =============================================================================
echo ""
echo "📦 Installing package managers..."

# Yarn classic (v1) — avoid Yarn Berry which has breaking changes
install_mise "yarn" "1"
install_mise "pnpm" "latest"
install_mise "bun"  "latest"

# =============================================================================
# Infrastructure
# =============================================================================
echo ""
echo "🏗️  Installing infrastructure tools..."

install_mise "terraform" "latest"

# =============================================================================
# LazyVim
# =============================================================================
echo ""
echo "📝 Setting up LazyVim..."

NVIM_CONFIG="$HOME/.config/nvim"

if [ ! -d "$NVIM_CONFIG" ]; then
  echo "  ✅ Cloning LazyVim starter..."
  git clone https://github.com/LazyVim/starter "$NVIM_CONFIG"
  # Remove git history so you can manage it as your own config
  rm -rf "$NVIM_CONFIG/.git"
  echo "  ✅ LazyVim ready — open nvim to install plugins"
else
  echo "  ⏭️  ~/.config/nvim already exists, skipping"
fi

# =============================================================================
# Done
# =============================================================================
echo ""
echo "✅ dev.sh complete"
echo ""
echo "📌 Manual steps required:"
echo "  - Restart terminal to apply mise activation"
echo "  - Open nvim to let LazyVim install plugins: nvim"
echo "  - Review and migrate your old dotfiles before running stow"
