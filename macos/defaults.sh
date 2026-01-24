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

echo "Restarting Dock to apply settings"
killall Dock 2>/dev/null || true

echo "Done. Some changes may require a logout/restart."
