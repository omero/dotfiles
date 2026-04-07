#!/bin/bash

# =============================================================================
# install.sh — Master setup script
# Usage:
#   ./install.sh           # Run all scripts in order
#   ./install.sh settings  # Run only settings.sh
#   ./install.sh apps      # Run only apps.sh
#   ./install.sh dev       # Run only dev.sh
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

run_settings() {
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  ⚙️  Running settings.sh..."
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  bash "$SCRIPT_DIR/settings.sh"
}

run_apps() {
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  🖥️  Running apps.sh..."
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  bash "$SCRIPT_DIR/apps.sh"
}

run_dev() {
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  🔧 Running dev.sh..."
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  bash "$SCRIPT_DIR/dev.sh"
}

case "${1:-all}" in
  settings)
    run_settings
    ;;
  apps)
    run_apps
    ;;
  dev)
    run_dev
    ;;
  all)
    run_settings
    run_apps
    run_dev
    ;;
  *)
    echo "❌ Unknown option: $1"
    echo ""
    echo "Usage:"
    echo "  ./install.sh           # Run all scripts in order"
    echo "  ./install.sh settings  # Run only settings.sh"
    echo "  ./install.sh apps      # Run only apps.sh"
    echo "  ./install.sh dev       # Run only dev.sh"
    exit 1
    ;;
esac

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✅ All done! Happy coding 🚀"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📌 Manual steps required:"
echo "  - Battery percentage: System Settings → Control Center → Battery → Show Percentage"
echo "  - Restart terminal to apply all changes"
echo "  - Sign in to GitHub CLI:  gh auth login"
echo "  - Import your GPG key or generate a new one"
echo "  - Configure your YubiKey:  ykman info"
echo "  - Open nvim to install LazyVim plugins:  nvim"
echo "  - Review and migrate your old dotfiles before running stow"
