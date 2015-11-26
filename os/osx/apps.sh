#!/usr/bin/env bash
set -eu

#
# Application installer (via brew-cask)
#

# Apps
apps=(
# Productivity
  evernote                          # Notes
  skitch                            # Screen Capture
  google-drive                      # Office
  libreoffice                       # Office
# Programming Tools
  atom                              # Programming text editor
  qlcolorcode                       # Syntax Highlighting
  quicklook-json                    # Preview JSON files
  qlmarkdown                        # QuickLook generator for Markdown files
  qlstephen                         # Quicklook files without file extension
  qlprettypatch                     # QuickLook generator for patch files.
  git                               # GIT
  github-desktop                    # Version control git client
  apikitchen                        # HTTP debugging tool
  vagrant                           # Virtual development environments
# Internet & Communication
  google-chrome                     # Web Browser
  firefox                           # Web Browser
  chromium                          # Web Browser
  opera                             # Web Browser
  adium                             # IM
  skype                             # Video Chat
# Reading and News
  kindle                            # eBook Reader
# Music, Photos, & Video
  xld                               # CD Ripper
  gimp                              # Image Editor
  vlc                               # Media Player
  movist                            # Media Player
  plex-media-server                 # Media Server
  vox                               # Music Player & SoundCloud Streamer
  spotify                           # Music Streaming Service
  handbrake                         # Video Encoder
  handbrakecli                      # Video Encoder Handbrak Command Line Interface
  makemkv                           # Video Encoder
# Utilities
  sophos-anti-virus-home-edition    # Antivirus
  clamxav                           # Antivirus
  transmission                      # BitTorrent Client
  macpaw-gemini                     # Duplicate File Finder
  disk-inventory-x                  # Disk Space Analyzer
  cyberduck                         # FTP - Free
  the-unarchiver                    # File Archive Utility
  flux                              # Health - Reduces Eye Strain
  lastpass                          # Password Manger
  hyperdock                         # prefernce pane
  sabnzbd                           # Usenet
  geekbench                         # Cross-platform processor benchmark
  geektool                          # Custome Information Display
  iterm2                            # Terminal Emulator
  caffeine                          # Stops Mac from Sleeping
  burn                              # Disc Burning
  appcleaner                        # Application Uninstaller
  onyx                              # System Tweaker
  anki                              # Flash Cards - SRS
  cheatsheet                        # Displays keyboard shortcuts
  eve                               # Learn Mac Shortcuts
  parallels-desktop                 # Virtual Machine
  vmware-fusion                     # Virtual Machine
  shiori                            # Pinboard and Delicious OS X client
)

# fonts
fonts=(
  font-m-plus
  font-clear-sans
  font-roboto
)

# Atom packages
atom=(
  advanced-railscasts-syntax
  atom-beautify
  cmd-9
  color-picker
  css-comb
  docblockr
  easy-motion
  editor-stats
  emmet
  fancy-new-file
  file-icons
  git-history
  highlight-selected
  image-view
  inc-dec-value
  key-peek
  language-jade
  linter
  markdown-preview
  merge-conflicts
  neutron-ui
  npm-install
  react
  vim-mode
  zentabs
)

# Specify the location of the apps
appdir="/Applications"

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

main() {

  # Ensure homebrew is installed
  homebrew

  # Install homebrew-cask
  echo "installing cask..."
  brew install caskroom/cask/brew-cask

  # Tap alternative versions
  brew tap caskroom/versions

  # Tap the fonts
  brew tap caskroom/fonts

  # install apps
  echo "installing apps..."
  brew cask install --appdir=$appdir ${apps[@]}

  # install fonts
  echo "installing fonts..."
  brew cask install ${fonts[@]}

  # install atom plugins
  echo "installing atom plugins..."
  apm install ${atom[@]}

  # link with alfred
  alfred
  cleanup
}

homebrew() {
  if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

alfred() {
  brew cask alfred link
}

cleanup() {
  brew cleanup
}

main "$@"
exit 0
