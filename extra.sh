openrazer() {
	cd
	yay -S openrazer-meta --noconfirm
	# add user to plugdev
	gpasswd -a mike plugdev
	# then reboot
	# install GUI
	yay -S razercommander --noconfirm
}

# npm live server
sudo npm install -g live-server

git clone --bare https://github.com/mathbike/.dotfiles.git $PWD/.dotfiles
/usr/bin/git --git-dir=$PWD/.dotfiles/ --work-tree=$PWD checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} rm {}
/usr/bin/git --git-dir=$PWD/.dotfiles/ --work-tree=$PWD checkout
/usr/bin/git --git-dir=$PWD/.dotfiles/ --work-tree=$PWD /usr/bin/git --git-dir=$PWD/.dotfiles/ --work-tree=$PWD --local status.showUntrackedFiles no

