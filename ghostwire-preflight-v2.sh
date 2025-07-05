#!/bin/bash

# Ghostwire Preflight Script v2 for Kiro Linux Live ISO
# Purpose: Remove minor bloat and prep base tools before install without breaking XFCE or Calamares

echo "🚀 Starting Ghostwire Preflight v2..."

# Remove non-critical bloat (but keep XFCE + Calamares functional)
echo "🧼 Removing non-critical bloat (vivaldi, welcome)..."
sudo pacman -Rns --noconfirm vivaldi welcome kvantum-qt5 ristretto mousepad xfc4-goodies || true

# Clean orphaned packages
echo "🧹 Cleaning orphan packages..."
sudo pacman -Rns --noconfirm $(pacman -Qdtq) 2>/dev/null || true

# Sync package databases
echo "📦 Updating package database..."
sudo pacman -Sy --noconfirm

# Install Ghostwire base packages
echo "🔧 Installing Ghostwire base tools..."
sudo pacman -S --noconfirm \
  hyprland \
  xdg-desktop-portal-hyprland \
  kitty foot \
  zsh starship \
  neofetch btop curl wget git \
  pipewire wireplumber pavucontrol \
  blueman network-manager-applet

# Skip SDDM if already present
if ! pacman -Q sddm-git &>/dev/null; then
  echo "💡 Installing SDDM..."
  sudo pacman -S --noconfirm sddm
else
  echo "⚠️  Skipping SDDM install – sddm-git already present."
fi

echo "✅ Ghostwire Preflight v2 complete."
echo "💡 Now run the Calamares installer. After reboot, your system will be clean and ready for Ghostwire Mod v1."
