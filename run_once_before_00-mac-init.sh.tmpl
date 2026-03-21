#!/bin/bash

echo "Starting macOS initialization..."

# Xcode Command Line Tools
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "Please complete the installation and then run 'chezmoi apply' again."
  exit 1
fi

# Homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Path for Apple Silicon Mac
  if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

# mise
if ! command -v mise &>/dev/null; then
  echo "Installing mise..."
  brew install mise
fi

echo "macOS initialization completed."
