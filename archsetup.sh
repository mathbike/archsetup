#!/bin/bash

# archsetup

packages() {
	sudo pacman -S --noconfirm \
		base-devel linux-headers linux-firmware \
		xorg-server xorg-xinit xorg-xrandr xorg-xsetroot libxft libxinerama xclip xorg-xinput \
		alsa-utils pulseaudio bashtop \
		ttf-jetbrains-mono man-db man-pages git github-cli \
		ufw gnupg pass passmenu python-pip xdotool \
		zathura zathura-pdf-mupdf brightnessctl nodejs npm gimp inkscape tlp \
		texlive-most coreutils
}




dotfiles() {
	git clone --bare https://github.com/mathbike/.dotfiles.git $HOME/.dotfiles
    alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    config checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} rm {}
    config checkout
}

