#!/bin/bash

# Ghostwire Preflight Script for Kiro Linux Live ISO
# Purpose: Strip bloat and install base tools before Calamares install

echo "🔧 Starting Ghostwire Preflight Cleanup..."

# Remove XFCE + bloatware
echo "🧹 Removing XFCE, Vivaldi, and theming tools..."
sudo pacman -Rns --noconfirm xfce4 xfce4-goodies mousepad ristretto vivaldi kvantum-qt5 lxappearance welcome

# Clean up orphaned packages
echo "🧼 Cleaning orphan packages..."
sudo pacman -Rns --noconfirm $(pacman -Qdtq) 2>/dev/null || true

# Update package database
echo "📦 Syncing package database..."
sudo pacman -Sy --noconfirm

# Install Ghostwire base tools
echo "🚀 Installing Ghostwire base packages..."
sudo pacman -S --noconfirm \
  hyprland \
  xdg-desktop-portal-hyprland \
  kitty foot \
  zsh starship \
  neofetch btop curl wget git \
  pipewire wireplumber pavucontrol \
  blueman network-manager-applet \
  sddm

# Set SDDM to start post-install
echo "🧠 Enabling SDDM after install..."
sudo systemctl enable sddm.service &>/dev/null || echo "⚠️ Will enable SDDM post-install manually."

echo "✅ Ghostwire preflight complete."
echo "📢 Now run the Calamares installer. After reboot, your system will be clean and ready for Ghostwire Mod v1."
