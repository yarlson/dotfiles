#!/bin/bash

set -e

echo "Setting up macOS defaults..."

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Guard: only run on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    log_warning "Not macOS, skipping defaults setup."
    exit 0
fi

set_keyboard_defaults() {
    log_info "Setting keyboard defaults..."

    # Fast key repeat
    defaults write NSGlobalDomain KeyRepeat -int 1
    defaults write NSGlobalDomain InitialKeyRepeat -int 10

    # Full keyboard access for all controls (Tab through all UI elements)
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

    # Disable press-and-hold for keys (enables key repeat in all apps)
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

    # Switch input source per application (each app remembers its own layout)
    defaults write com.apple.HIToolbox AppleGlobalTextInputProperties -dict TextInputGlobalPropertyPerContextInput -bool true

    # Disable text completion suggestions
    defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool false

    # Disable Dictation auto-enable (prevents accidental Fn/Globe double-press activation)
    defaults write com.apple.HIToolbox AppleDictationAutoEnable -bool false

    # Fn/Globe key acts as standard Fn modifier, not emoji picker
    defaults write com.apple.HIToolbox AppleFnUsageType -int 0

    # Reduce input source switch delay
    defaults write com.apple.HIToolbox AppleCurrentKeyboardLayoutInputSourceSwitchDelay -float 0

    # Use Caps Lock to switch input source
    defaults write NSGlobalDomain TISRomanSwitchState -int 1

    # Disable auto-correct and smart substitutions
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
    defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
    defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

    log_success "Keyboard defaults set"
}

set_trackpad_defaults() {
    log_info "Setting trackpad defaults..."

    # Enable tap to click
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

    # Enable three-finger drag
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

    # Increase tracking speed
    defaults write NSGlobalDomain com.apple.trackpad.scaling -float 1

    log_success "Trackpad defaults set"
}

set_dock_defaults() {
    log_info "Setting Dock defaults..."

    # Auto-hide the Dock
    defaults write com.apple.dock autohide -bool true

    # Remove the auto-hide delay
    defaults write com.apple.dock autohide-delay -float 0

    # Speed up the hide/show animation
    defaults write com.apple.dock autohide-time-modifier -float 0.15

    # Small tile size
    defaults write com.apple.dock tilesize -int 36

    # Don't show recent applications
    defaults write com.apple.dock show-recents -bool false

    # Minimize windows into their application icon
    defaults write com.apple.dock minimize-to-application -bool true

    # Scale effect (faster than genie)
    defaults write com.apple.dock mineffect -string "scale"

    # Don't animate opening applications
    defaults write com.apple.dock launchanim -bool false

    # Don't automatically rearrange Spaces based on most recent use
    defaults write com.apple.dock mru-spaces -bool false

    # Don't group windows by application in Mission Control
    defaults write com.apple.dock expose-group-apps -bool false

    # Speed up Mission Control animation
    defaults write com.apple.dock expose-animation-duration -float 0.1

    log_success "Dock defaults set"
}

set_finder_defaults() {
    log_info "Setting Finder defaults..."

    # Show all filename extensions
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true

    # Show hidden files
    defaults write com.apple.finder AppleShowAllFiles -bool true

    # Show status bar and path bar
    defaults write com.apple.finder ShowStatusBar -bool true
    defaults write com.apple.finder ShowPathbar -bool true

    # Display full POSIX path in title bar
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

    # Keep folders on top when sorting by name
    defaults write com.apple.finder _FXSortFoldersFirst -bool true

    # Default to list view
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

    # Search the current folder by default
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

    # Disable warning when changing file extension
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

    # Avoid .DS_Store files on network and USB volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

    # Show ~/Library
    chflags nohidden ~/Library

    # New Finder window opens home directory
    defaults write com.apple.finder NewWindowTarget -string "PfHm"
    defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

    log_success "Finder defaults set"
}

set_screenshot_defaults() {
    log_info "Setting screenshot defaults..."

    # Save screenshots to ~/Screenshots
    mkdir -p "${HOME}/Screenshots"
    defaults write com.apple.screencapture location -string "${HOME}/Screenshots"

    # Save as PNG
    defaults write com.apple.screencapture type -string "png"

    # Disable shadow
    defaults write com.apple.screencapture disable-shadow -bool true

    log_success "Screenshot defaults set"
}

set_system_ui_defaults() {
    log_info "Setting system UI defaults..."

    # Always hide menu bar (both keys needed on Sonoma/Sequoia)
    defaults write .GlobalPreferences _HIHideMenuBar -bool true
    defaults write .GlobalPreferences AppleMenuBarVisibleInFullscreen -bool false

    # Expand save panel by default
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

    # Expand print panel by default
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

    # Save to disk (not iCloud) by default
    defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

    # Disable the "Are you sure you want to open this application?" dialog
    defaults write com.apple.LaunchServices LSQuarantine -bool false

    log_success "System UI defaults set"
}

set_misc_defaults() {
    log_info "Setting misc defaults..."

    # Speed up window resize animations
    defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

    # Disable window open animations
    defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

    # Show scroll bars when scrolling
    defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

    # Disable Resume system-wide
    defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

    # Disable automatic termination of inactive apps
    defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

    log_success "Misc defaults set"
}

restart_affected_apps() {
    log_info "Restarting affected applications..."

    # Flush preferences cache so HIToolbox changes (input source switching) take effect
    killall cfprefsd &>/dev/null || true

    local apps=(
        "Dock"
        "Finder"
        "SystemUIServer"
    )

    for app in "${apps[@]}"; do
        killall "$app" &>/dev/null || true
    done

    log_success "Applications restarted. Some changes may require a logout/restart."
}

main() {
    set_keyboard_defaults
    set_trackpad_defaults
    set_dock_defaults
    set_finder_defaults
    set_screenshot_defaults
    set_system_ui_defaults
    set_misc_defaults

    restart_affected_apps

    log_success "macOS defaults configured!"
}

main "$@"
