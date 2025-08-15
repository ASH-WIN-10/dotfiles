#!/usr/bin/env bash
set -euo pipefail

# Colors
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

msg() {
    echo -e "\n${CYAN}==>${RESET} $1"
}

complete() {
    echo -e "\n${CYAN}==>${RESET} ${GREEN}$1${RESET}\n"
}

prompt() {
    read -rp "$(echo -e "\n${YELLOW}$1 (y/n): ${RESET}")" choice
    [[ "$choice" =~ ^[Yy]$ ]]
}

# Ensure script is run on Arch
if ! grep -qi "arch" /etc/os-release; then
    echo "This script is only for Arch Linux."
    exit 1
fi

# Update system
msg "Updating the system..."
sudo pacman -Syu --noconfirm

# Base dependencies
msg "Installing base dependencies..."
sudo pacman -S --needed --noconfirm curl wget unzip git base-devel stow

# Install yay if not already installed
if ! command -v yay >/dev/null 2>&1; then
    msg "Installing yay..."

    tmpdir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
    pushd "$tmpdir/yay"
    makepkg -si --noconfirm
    popd
    rm -rf "$tmpdir"

    complete "yay installed successfully!!"
else
    msg "yay is already installed."
fi

# Dotfiles
if prompt "Install dotfiles?"; then
    msg "Installing dotfiles..."
    if [[ ! -d "$HOME/dotfiles" ]]; then
        git clone https://github.com/ASH-WIN-10/dotfiles.git "$HOME/dotfiles"
    fi
    pushd "$HOME/dotfiles"
    stow fastfetch homedir nvim scripts tmux wlogout \
        ghostty hypr kitty pywal rofi swaync waybar waypaper
    popd

    msg "Installing dependencies for dotfiles..."
    yay -S --needed --noconfirm \
        hyprland python-pywal waybar \
        rofi-wayland rofimoji swaync poweralertd \
        wl-clipboard cliphist waypaper swww wlogout \
        hyprshot hypridle hyprlock zen-browser-bin \
        nautilus sushi ghostty \
        nm-applet blueberry

    complete "dotfiles installed successfully!!"
fi

# Polkit
if prompt "Setup polkit agent?"; then
    yay -S --needed --noconfirm polkit hyprpolkitagent
    sudo systemctl enable polkit.service

    complete "Polkit agent setup complete!!"
fi

# Fonts
if prompt "Install fonts?"; then
    msg "Installing fonts..."
    mkdir -p "$HOME/.local/share/fonts"
    tmpdir=$(mktemp -d)
    wget -qO "$tmpdir/alfa.zip" https://www.1001fonts.com/download/alfa-slab-one.zip
    unzip -q "$tmpdir/alfa.zip" -d "$HOME/.local/share/fonts"
    yay -S --needed --noconfirm \
        noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra \
        ttf-jetbrains-mono-nerd
    rm -rf "$tmpdir"

    complete "Fonts installed successfully!!"
fi

# Cursor theme
if prompt "Install cursor theme?"; then
    tmpdir=$(mktemp -d)
    wget -qO "$tmpdir/cursor.tar.xz" \
        https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Ice.tar.xz
    tar -xf "$tmpdir/cursor.tar.xz" -C "$tmpdir"
    mkdir -p "$HOME/.local/share/icons"
    mv "$tmpdir/Bibata-Modern-Ice" "$HOME/.local/share/icons/"
    rm -rf "$tmpdir"

    complete "Cursor theme installed successfully!!"
fi

# Wallpapers
if prompt "Add wallpapers?"; then
    mkdir -p "$HOME/Pictures/Wallpapers/all"
    tmpdir=$(mktemp -d)
    git clone https://github.com/ASH-WIN-10/wallpapers.git "$tmpdir"
    mv "$tmpdir"/* "$HOME/Pictures/Wallpapers/all/"
    rm -rf "$tmpdir"

    complete "Wallpapers added successfully!!"
fi

# archinstall has integrated this feature, so might remove this in future after testing
# Bluetooth
# if prompt "Setup bluetooth?"; then
#     yay -S --needed --noconfirm bluez bluez-utils bluez-deprecated-tools
#     sudo modprobe btusb
#     sudo systemctl enable bluetooth.service
# fi

# Terminal utilities
if prompt "Install terminal utilities?"; then
    yay -S --needed --noconfirm \
        neovim tmux bat eza fd fzf ripgrep zoxide dust btop

    msg "Installing Tmux Plugin Manager (TPM)...";
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true
    msg "TPM installed. Inside tmux, press 'Prefix(ctrl-a) + I' to install plugins."
fi

# Zsh
if prompt "Install zsh and plugins?"; then
    yay -S --needed --noconfirm zsh zsh-autosuggestions zsh-syntax-highlighting starship
    RUNZSH="no" KEEP_ZSHRC="yes" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

complete "Setup complete!!"
