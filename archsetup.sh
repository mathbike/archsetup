#!/bin/bash

# archsetup

packages() {
	sudo pacman -S --noconfirm \
		base-devel linux-headers linux-firmware ufw python-pip brightnessctl code \
		xorg-server xorg-xinit xorg-xrandr xorg-xsetroot libxft libxinerama xclip xorg-xinput xdotool \
		coreutils alsa-utils pulseaudio bashtop ttf-jetbrains-mono man-db man-pages git github-cli tlp
}

packages() {
	sudo pacman -S --noconfirm \
		gnupg pass passmenu zathura zathura-pdf-mupdf nodejs npm gimp inkscape texlive-most
}


dotfiles() {
	git clone --bare https://github.com/mathbike/.dotfiles.git $HOME/.dotfiles
    alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    config checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} rm {}
    config checkout
}

