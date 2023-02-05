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
