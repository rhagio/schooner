#!/bin/bash

# To be run each time user logs into account but before KDE startup. 
# Note that this script must have .sh suffix to be picked up by KDE
declare -r EnableSource="Enabled"
source /bin/sch-source-common

# Dropbox adds itself to autostart each time it runs. So delete autostart entry to stop Dropbox
# nagging - unless the user has explicitly allowed it.
# TODO need to resolve how this interacts with Dropbox "run on startup" option
if [[ "$(read-sch-user-config 'disable-dropbox-startup-nag')" == 'yes' ]]; then
	rm ~/.config/autostart/dropbox.desktop
fi

# If this is first time login replace placeholder that stood in for /home/username
if [[ "$(read-sch-user-config 'first-user-run')" == 'yes' ]]; then
	sch-global-replace-placeholder-with-userpath
	write-sch-user-config 'first-user-run' 'no'
fi

# disabling samba requires sudo so can't be directly done in local config  
if [[ "$(read-sch-user-config 'disable-samba-on-startup')" == 'yes' ]]; then
	sch-global-replace-placeholder-with-userpath
	write-sch-user-config 'first-user-run' 'no'
fi
sudo service smbd stop

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