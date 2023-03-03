#!/bin/bash

pacman() {
	pacman -S --needed - < pkglist.txt
}

packages_base() {
	pacman -S --noconfirm \
		base-devel linux-headers linux-firmware ufw tlp brightnessctl coreutils alsa-utils pulseaudio \
		xorg-server xorg-xinit xorg-xrandr xorg-xsetroot libxft libxinerama xclip xorg-xinput xdotool \
		python-pip bashtop ttf-jetbrains-mono man-db man-pages git github-cli gnupg gvim solaar zip unzip keepassxc
}

packages_extra() {
	pacman -S --noconfirm \
		nodejs npm gimp inkscape freecad texlive-most zathura zathura-pdf-mupdf
	mkdir -p $HOME/.config/zathura && ln -s $HOME/zathurarc $HOME/.config/zathura
}

firewall() {
	systemctl enable ufw.service
	ufw default deny incoming
	sudo ufw default allow outgoing
	sudo ufw logging off
	sudo ufw enable
}

dotfiles() {
	git clone --bare https://github.com/mathbike/.dotfiles.git $HOME/.dotfiles
	/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} rm {}
	/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
	#/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME --local status.showUntrackedFiles no
	echo "[status]" >> $HOME/.dotfiles/config 
	echo "	showUntrackedFiles = no" >> $HOME/.dotfiles/config
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
	git clone https://aur.archlinux.org/yay-git.git $HOME/.config/yay
	cd $HOME/.config/yay && makepkg -si --noconfirm && cd
	yay -S brave-bin --noconfirm
	sudo rm /etc/tlp.conf && ln -s $HOME/tlp.conf /etc/ && sudo systemctl enable tlp.service
	sudo rm /etc/vimrc && ln -s $HOME/.vimrc /etc/
}

vscodium() {
	yay -S vscodium --noconfirm
	cp $HOME/archsetup/settings.json $HOME/.config/VSCodium/User/
	codium --install-extension ms-python.python
	codium --install-extension GitHub.vscode-pull-request-github
	codium --install-extension PKief.material-icon-theme
	codium --install-extension ritwickdey.LiveServer
	codium --install-extension James-Yu.latex-workshop
	codium --install-extension alexcvzz.vscode-sqlite
}

#packages_base
#packages_extra
#firewall
#dotfiles
#configuration
#other
#vscodium
