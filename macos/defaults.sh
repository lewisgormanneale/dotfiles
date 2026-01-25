#!/usr/bin/env bash
set -euo pipefail

echo "• Key repeat settings"
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2

echo "• Showing all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "• Enable dark mode and dark menu/dock icons"
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
defaults write NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically -bool false

echo "• Dock preferences"
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock orientation -string "bottom"

echo "• Aerospace settings"
# Disable window animations for better tiling responsiveness
defaults write NSGlobalDomain NSWindowResizeTime -float 0.1
# Disable dock animations
defaults write com.apple.dock autohide-time-modifier -float 0.5
# Mission Control: Group windows by application (fixes window sizing issues: https://nikitabobko.github.io/AeroSpace/guide#a-note-on-mission-control)
defaults write com.apple.dock expose-group-apps -bool true
# Disable 'Displays have separate Spaces' for better multi-monitor stability (see: https://nikitabobko.github.io/AeroSpace/guide#a-note-on-displays-have-separate-spaces)
defaults write com.apple.spaces spans-displays -bool true

echo "• Hide macOS menu bar (for sketchybar)"
# Automatically hide and show the menu bar (set to Always)
defaults write NSGlobalDomain AppleMenuBarVisible -bool false

echo "• Change Screenshot Location"„
mkdir -p ~/Pictures/Screenshots
defaults write com.apple.screencapture location -string "${HOME}/Pictures/Screenshots"

echo "Restarting Dock and SystemUIServer to apply settings"
killall Dock 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

echo "Done. Some changes may require a logout/restart e.g. 'Displays have separate spaces'."
