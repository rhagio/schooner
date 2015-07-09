#!/bin/dash
. /usr/bin/sch-includes

# Dropbox adds itself to autostart each time it runs. So delete autostart entry to stop Dropbox
# nagging - unless the user has explicitly allowed it.
# TODO need to resolve how this interacts with Dropbox "run on startup" option
if [ "$(get_user_conf 'disable-dropbox-startup-nag')" = 'yes' ]; then
	rm $HOME/.config/autostart/dropbox.desktop
fi

# If this is first time login replace placeholder that stood in for /home/username
if [ "$(get_user_conf 'first-user-run')" = 'yes' ]; then
	#sch-global-replace-placeholder-with-userpath
	User="$(whoami)"
	HomeDir="/home/$User"
	#clumsy but can't make work without hard-coding!
	grep -rl "$PlaceHolder" $HomeDir |  xargs sed -i "s/$PlaceHolder/\/home\/$User/g"
	set_user_conf 'first-user-run' 'no'

fi

# disabling samba requires sudo so can't be directly done in local config - wha????
#if [ "$(get_user_conf 'disable-samba-on-startup')" == 'yes' ]; then
#	sch-global-replace-placeholder-with-userpath
	#get_user_conf 'first-user-run' 'no'
#fi
#sudo service smbd stop

# TODO always set recent url entry in ksnapshotrc to ~/Screenshots so it will save there by default. As it has no persist.

# Resets
#ccom-reset-dolphin.sh
#ccom-reset-gimp.sh
#ccom-reset-gwenview.sh
#ccom-reset-k3b.sh
#ccom-reset-mozilla.sh
#ccom-reset-kicker.sh
#ccom-reset-kwrite.sh
#ccom-reset-recoll.sh
#ccom-reset-smplayer.sh
#ccom-reset-vokoscreen.sh
#ccom-reset-xbmc.sh
