#!/bin/bash
#
# install_banana.sh
#
# Sets up the banana command (Epitech coding-style checker wrapper) on a
# fresh Ubuntu machine using bash. Installs Docker if missing, clones the
# scripts repo, and wires the aliases into ~/.bashrc.
# #TODO: Add support for zsh and other shells.
# #TODO: Add support for fedora
# Usage: ./install_banana.sh

set -euo pipefail

REPO_URL="https://github.com/alrikn/scripts.git"
TARGET_DIR="$HOME/scripts"
BASHRC="$HOME/.bashrc"
SOURCE_LINE="source $TARGET_DIR/rc.sh $TARGET_DIR"

echo "==> Installing dependencies (git, curl)..."
sudo apt-get update -y
sudo apt-get install -y git curl

echo "==> Checking for Docker..."
if ! command -v docker >/dev/null 2>&1; then
    echo "Docker not found, installing via apt..."
    sudo apt-get install -y docker.io
    sudo systemctl enable --now docker
else
    echo "Docker already installed: $(docker --version)"
fi

echo "==> Adding $USER to the docker group (avoids needing sudo for every docker call)..."
if ! groups "$USER" | grep -qw docker; then
    sudo usermod -aG docker "$USER"
    NEEDS_RELOGIN=1
else
    NEEDS_RELOGIN=0
fi

echo "==> Cloning scripts repo..."
if [ -d "$TARGET_DIR/.git" ]; then
    echo "Repo already present at $TARGET_DIR, pulling latest instead."
    git -C "$TARGET_DIR" pull
else
    git clone "$REPO_URL" "$TARGET_DIR"
fi

echo "==> Wiring aliases into $BASHRC..."
if ! grep -qF "$SOURCE_LINE" "$BASHRC" 2>/dev/null; then
    printf '\n# Load custom scripts (banana, coding-style, etc.)\n%s\n' "$SOURCE_LINE" >>"$BASHRC"
    echo "Added: $SOURCE_LINE"
else
    echo "Already present, skipping."
fi

echo
echo "==> Done."
echo "Run 'source ~/.bashrc' (or open a new terminal) to load 'banana'."
if [ "$NEEDS_RELOGIN" -eq 1 ]; then
    echo "NOTE: you were just added to the 'docker' group — log out and back in"
    echo "      (or run 'newgrp docker') for that to take effect without sudo."
fi
