#!/bin/bash

	# set screen brightness
	# xrandr --output eDP-1 --brightness 1

asus() {
	# disable touchscreen
	xinput -disable 13
	# disable webcam
	xinput -disable 12
}

hp() {
	# disable laptop display
	xrandr --output eDP-1 --off
	# disable touchscreen
	xinput -disable 15
	# disable webcam
	xinput -disable 13
        # disable IR camera
	xinput -disable 14       
}

T420() {
	:
}

X220() {
	# disable webcam
	xinput -disable 10
}

asus
#hp
#T420
#X220

