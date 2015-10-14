#!/bin/bash

# ==============================================================================
# wasta-custom-mxb-postinst.sh
#
#   This script is automatically run by the postinst configure step on
#       installation of wasta-custom-mxb.  It can be manually re-run, but is
#       only intended to be run at package installation.  
#
#   2015-09-14-06 rik: initial script
#
# ==============================================================================

# ------------------------------------------------------------------------------
# Check to ensure running as root
# ------------------------------------------------------------------------------
#   No fancy "double click" here because normal user should never need to run
if [ $(id -u) -ne 0 ]
then
	echo
	echo "You must run this script with sudo." >&2
	echo "Exiting...."
	sleep 5s
	exit 1
fi

# ------------------------------------------------------------------------------
# Initial Setup
# ------------------------------------------------------------------------------

echo
echo "*** Beginning wasta-custom-mxb-postinst.sh"
echo

# ------------------------------------------------------------------------------
# LibreOffice Preferences Extension install (for all users)
# ------------------------------------------------------------------------------

# First, REMOVE any existing extension (so will be replaced with newer version
#    so updates work: otherwise the install will error saying already installed)
# Send error to null so won't display
EXT_FOUND=$(ls /var/spool/libreoffice/uno_packages/cache/uno_packages/*/wasta-english-intl-defaults.oxt* 2> /dev/null)

if [ "$EXT_FOUND" ];
then
    unopkg remove --shared wasta-english-intl-defaults.oxt
fi

# Install wasta-english-intl-defaults.oxt (Default LibreOffice Preferences)
echo
echo "*** Installing/Updating Wasta English Intl Default LO Extension"
echo
# 2015-09-14 RIK: COMMENTING OUT SINCE MXB PROBABLY DOESN'T WANT
#   WASTA INTL DEFAULTS (CM, GB ENG, ETC).  BUT THIS SHOWS HOW TO DO IT.

# unopkg add --shared /usr/share/wasta-custom-eth/resources/wasta-english-intl-defaults.oxt

# IF user has not initialized LibreOffice, then when adding the above shared
#   extension, the user's LO settings are created, but owned by root so
#   they can't change them: solution is to just remove them (will get recreated
#   when user starts LO the first time).

for LO_FOLDER in /home/*/.config/libreoffice;
do
    LO_OWNER=$(stat -c '%U' $LO_FOLDER)

    if [ "$LO_OWNER" == "root" ];
    then
        echo
        echo "*** LibreOffice settings owned by root: resetting"
        echo "*** Folder: $LO_FOLDER"
        echo
    
        rm -rf $LO_FOLDER
    fi
done

# insert keyboard install scripting here

# ------------------------------------------------------------------------------
# Finished
# ------------------------------------------------------------------------------

echo
echo "*** Finished with wasta-custom-mxb-postinst.sh"
echo

exit 0
