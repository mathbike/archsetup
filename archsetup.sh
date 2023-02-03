#!/bin/bash

# archsetup

packages_base() {
	sudo pacman -S --noconfirm \
		base-devel linux-headers linux-firmware ufw python-pip brightnessctl code gvim solaar \
		xorg-server xorg-xinit xorg-xrandr xorg-xsetroot libxft libxinerama xclip xorg-xinput xdotool \
		coreutils alsa-utils pulseaudio bashtop ttf-jetbrains-mono man-db man-pages git github-cli tlp
}

packages_extra() {
	sudo pacman -S --noconfirm \
		gnupg pass passmenu zathura zathura-pdf-mupdf nodejs npm gimp inkscape texlive-most freecad
}

firewall() {
	sudo systemctl enable ufw.service
	sudo ufw default deny incoming
	sudo ufw default allow outgoing
	sudo ufw logging off
	sudo ufw enable
}

dotfiles() {
	git clone --bare https://github.com/mathbike/.dotfiles.git $HOME/.dotfiles
    alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    config checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} rm {}
    config checkout
	config config --local status.showUntrackedFiles no
}

configuration() {
	git clone https://github.com/mathbike/suckless.git $HOME/.config/suckless
	cd $HOME/.config/suckless/st && sudo make install
	cd $HOME/.config/suckless/dwm && sudo make install
	cd $HOME/.config/suckless/dwm/dwmblocks && sudo make install
	cd $HOME/.config/suckless/dmenu && sudo make install && cd
	ln -s $HOME/.config/suckless/dwm/dwmstatusbar/sb-battery.sh /usr/local/bin
	ln -s $HOME/.config/suckless/dwm/dwmstatusbar/sb-brightness.sh /usr/local/bin
	ln -s $HOME/.config/suckless/dwm/dwmstatusbar/sb-date.sh /usr/local/bin
	ln -s $HOME/.config/suckless/dwm/dwmstatusbar/sb-volume.sh /usr/local/bin
}

other() {
	# yay
	git clone https://aur.archlinux.org/yay-git.git $HOME/.config/yay
	cd $HOME/.config/yay && makepkg -si --noconfirm
	# brave
	yay -S brave-bin --noconfirm

}

