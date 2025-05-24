#!/usr/bin/env bash


# yay
echo "\nInstalling yay..."
sudo pacman -S --needed --noconfirm git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si


# update the system
read -p $'\nUpdate the system? (y/n): ' update_system
if [[ $update_system == "y" || $update_system == "Y" ]]; then
    echo "\n\nUpdating the system..."
    yay -Syu --noconfirm
fi


# dependencies
echo "\n\nInstalling dependencies..."
yay -S --needed --noconfirm \
    curl \
    wget \
    unzip \
    stow


# dotfiles
read -p $'\nInstall dotfiles? (y/n): ' install_dotfiles
if [[ $install_dotfiles == "y" || $install_dotfiles == "Y" ]]; then
    echo "\n\nInstalling dotfiles..."
    cd ~ && git clone https://github.com/ASH-WIN-10/dotfiles.git
    cd dotfiles
    stow fastfetch homedir nvim scripts tmux wlogout \
        ghostty hypr kitty pywal rofi swaync waybar

    # packages
    echo "\n\nInstalling packages..."
    yay -S --needed --noconfirm \
        hyprland \
        python-pywal \
        waybar \
        rofi-wayland rofimoji\
        swaync powerlalertd \
        wl-clipboard cliphist \
        hyprpaper swww \
        ghostty \
        wlogout \
        hyprshot \
        hypridle hyprlock \
        zen-browser-bin google-chrome \
        nautilus shushi
fi


# setup polkit agent
read -p $'\nSetup polkit agent? (y/n): ' setup_polkit
if [[ $setup_polkit == "y" || $setup_polkit == "Y" ]]; then
    echo "\n\nSetting up polkit agent..."
    yay -S --needed --noconfirm \
        polkit \
        hyprpolkitagent
    sudo systemctl enable --now polkit.service
fi


# fonts
read -p $'\nInstall fonts? (y/n): ' install_fonts
if [[ $install_fonts == "y" || $install_fonts == "Y" ]]; then
    echo "\n\nInstalling fonts..."
    cd ~ && mkdir -p ~/.local/share/fonts
    wget https://www.1001fonts.com/download/alfa-slab-one.zip
    unzip alfa-slab-one.zip -d ~/.local/share/fonts
    rm alfa-slab-one.zip

    yay -S --needed --noconfirm \
        noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra \
        ttf-jetbrains-mono-nerd
fi


# cursor themse
read -p $'\nInstall cursor theme? (y/n): ' install_theme
if [[ $install_theme == "y" || $install_theme == "Y" ]]; then
    wget https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Ice.tar.xz
    tar -xvf Bibata-Modern-Ice.tar.xz
    mv Bibata-Modern-Ice ~/.local/share/icons/
    rm Bibata-Modern-Ice.tar.xz
fi

# wallpapers
read -p $'\nInstall wallpapers? (y/n): ' install_wallpapers
if [[ $install_wallpapers == "y" || $install_wallpapers == "Y" ]]; then
    echo "\n\nInstalling wallpapers..."
    mkdir -p ~/Pictures/Wallpapers/all
    cd ~/Pictures/Wallpapers/all
    git clone https://github.com/ASH-WIN-10/wallpapers.git
    mv wallpapers/* .
    rm -r wallpapers && cd ~
fi


# setting up bluetooth
read -p $'\nSetup bluetooth? (y/n): ' setup_bluetooth
if [[ $setup_bluetooth == "y" || $setup_bluetooth == "Y" ]]; then
    echo "\n\nSetting up bluetooth..."
    yay -S --needed --noconfirm \
        bluez \
        bluez-utils \
        bluez-deprecated-tools
    modprobe btusb
    sudo systemctl enable --now bluetooth.service
fi


# package managers (flatpak)
read -p $'\nInstall flatpak? (y/n): ' install_flatpak
if [[ $install_flatpak == "y" || $install_flatpak == "Y" ]]; then
    echo "\n\nInstalling flatpak..."
    yay -S --needed --noconfirm flatpak
fi


# zsh
read -p $'\nInstall zsh and plugins? (y/n): ' install_zsh
if [[ $install_zsh == "y" || $install_zsh == "Y" ]]; then
    echo "\n\nInstalling zsh and plugins..."
    yay -S --needed --noconfirm \
        zsh \
        zsh-autosuggestions \
        zsh-syntax-highlighting \
    curl -sS https://starship.rs/install.sh | sh
fi


# terminal utilities
read -p $'\nInstall terminal utilities? (y/n): ' install_termutils
if [[ $install_termutils == "y" || $install_termutils == "Y" ]]; then
    echo "\n\nInstalling terminal utilities..."
    yay -S --needed --noconfirm \
        neovim \
        tmux \
        bat \
        eza \
        fd \
        fzf \
        ripgrep \
        zoxide \
        dust \
        btop
fi


# tpm
read -p $'\nInstall Tmux Plugin Manager(TPM)? (y/n): ' install_tpm
if [[ $install_tpm == "y" || $install_tpm == "Y" ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "\n\nTmux Plugin Manager installed. Press prefix + I in 'tmux' to install plugins."
fi
