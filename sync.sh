#!/usr/bin/env bash
set -e

REPO_DIR="$HOME/termux-central"
BIN_DIR="$HOME/.local/bin"

mkdir -p "$BIN_DIR"

if [ -d "$REPO_DIR/.git" ]; then
  git -C "$REPO_DIR" pull --ff-only
fi

if [ -d "$REPO_DIR/bin" ]; then
  cp -f "$REPO_DIR"/bin/* "$BIN_DIR"/
  chmod +x "$BIN_DIR"/*
fi

if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc" 2>/dev/null; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi

if ! grep -q 'alias puxar=' "$HOME/.bashrc" 2>/dev/null; then
  echo 'alias puxar="bash $HOME/termux-central/sync.sh"' >> "$HOME/.bashrc"
fi

echo "========================================"
echo "CENTRAL ATUALIZADA COM SUCESSO!"
echo "Comandos prontos: porteiro | agy | backup | puxar"
echo "========================================"
