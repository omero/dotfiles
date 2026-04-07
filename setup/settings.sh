#!/bin/bash

# =============================================================================
# settings.sh — macOS system configuration (idempotent)
# Compatible with macOS Tahoe (16) and later
# =============================================================================

set -e

# Helper to apply a default only if the value has changed
apply_default() {
  local domain=$1 key=$2 type=$3 value=$4
  local current
  current=$(defaults read "$domain" "$key" 2>/dev/null || echo "__unset__")
  if [ "$current" != "$value" ]; then
    defaults write "$domain" "$key" "$type" "$value"
    echo "  ✅ $key → $value"
  else
    echo "  ⏭️  $key already set"
  fi
}

echo ""
echo "⌨️  Keyboard..."
# How fast a key repeats when held down (1 = fastest, not configurable via UI)
apply_default NSGlobalDomain KeyRepeat -int 1
# How long to wait before key repeat kicks in (10 = short delay)
apply_default NSGlobalDomain InitialKeyRepeat -int 10
# Disable automatic spell correction
apply_default NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# Disable automatic capitalization at the start of a sentence
apply_default NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
# Disable automatic period insertion when double-tapping space
apply_default NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

echo ""
echo "🗂️  Finder..."
# Show hidden files and folders (dotfiles like .env, .gitignore, etc.)
apply_default com.apple.finder AppleShowAllFiles -bool true
# Always show file extensions (e.g. file.txt instead of just file)
apply_default NSGlobalDomain NSShowAppCExtensions -bool true
# Show full directory path in the Finder title bar
apply_default com.apple.finder _FXShowPosixPathInTitle -bool true
# Disable the warning dialog when changing a file extension
apply_default com.apple.finder FXEnableExtensionChangeWarning -bool false
# Open the Home folder by default when opening a new Finder window
apply_default com.apple.finder NewWindowTarget -string "PfHm"
# Prevent macOS from creating .DS_Store files on network drives
apply_default com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Prevent macOS from creating .DS_Store files on USB and external drives
apply_default com.apple.desktopservices DSDontWriteUSBStores -bool true

echo ""
echo "🖱️  Trackpad..."
# Enable tap to click without physically pressing the trackpad
apply_default com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# Enable two-finger tap for right-click
apply_default com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
# Cursor tracking speed (2.5 = fast, max is 3.0)
apply_default NSGlobalDomain com.apple.trackpad.scaling -float 1.5

echo ""
echo "🚀 Dock..."
# Auto-hide the Dock when the cursor is not over it
apply_default com.apple.dock autohide -bool true
# Remove the delay before the Dock appears when hovering
apply_default com.apple.dock autohide-delay -float 0
# Speed of the show/hide animation (0.3 seconds)
apply_default com.apple.dock autohide-time-modifier -float 0.3
# Hide the "Recent Apps" section from the Dock
apply_default com.apple.dock show-recents -bool false
# Size of Dock icons in pixels
apply_default com.apple.dock tilesize -int 48

echo ""
echo "🌀 Animations..."
# Disable the bounce animation when opening apps from the Dock
apply_default com.apple.dock launchanim -bool false
# Use "scale" effect when minimizing windows — faster than the default "genie"
apply_default com.apple.dock mineffect -string scale
# Reduce window resize animation duration (0.1 = nearly instant)
apply_default NSGlobalDomain NSWindowResizeTime -float 0.1

echo ""
echo "🔥 Hot Corners..."
# Available corner actions:
#   0  = Disabled
#   2  = Mission Control
#   3  = Application Windows
#   4  = Desktop
#   10 = Sleep Display
#   11 = Launchpad
#   12 = Notification Center
#   13 = Lock Screen
#
# Modifier key required to trigger (0 = none)

# ↖️ Top Left → Application Windows
apply_default com.apple.dock wvous-tl-corner -int 2
apply_default com.apple.dock wvous-tl-modifier -int 0
# ↗️ Top Right → Notification Center
apply_default com.apple.dock wvous-tr-corner -int 12
apply_default com.apple.dock wvous-tr-modifier -int 0
# ↙️ Bottom Left → Desktop
apply_default com.apple.dock wvous-bl-corner -int 4
apply_default com.apple.dock wvous-bl-modifier -int 0
# ↘️ Bottom Right → Launchpad
apply_default com.apple.dock wvous-br-corner -int 11
apply_default com.apple.dock wvous-br-modifier -int 0

echo ""
echo "🔒 Security..."
# Require password when waking from screen saver or sleep
apply_default com.apple.screensaver askForPassword -bool true
# Ask for password immediately with no grace period
apply_default com.apple.screensaver askForPasswordDelay -int 0

# Enable the Firewall to block unsolicited incoming connections
# Especially useful on public networks like cafes or airports
# Requires administrator privileges (sudo)
if [ "$(sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate | grep -c 'enabled')" -eq 0 ]; then
  echo "  ✅ Enabling Firewall..."
  sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
else
  echo "  ⏭️  Firewall already enabled"
fi

echo ""
echo "🔍 Spotlight — disable indexing on external drives..."
# Prevent Spotlight from indexing external drives and creating .Spotlight-V100 folders
if [ -d "/.Spotlight-V100" ]; then
  sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
  echo "  ✅ Spotlight indexing disabled on external drives"
else
  echo "  ⏭️  /.Spotlight-V100 not found, skipping (may not apply on this macOS version)"
fi

echo ""
echo "🔄 Restarting affected services..."
killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

echo ""
echo "✅ settings.sh complete"
echo ""
echo "📌 Manual steps required:"
echo "  - Battery percentage: System Settings → Control Center → Battery → Show Percentage"
