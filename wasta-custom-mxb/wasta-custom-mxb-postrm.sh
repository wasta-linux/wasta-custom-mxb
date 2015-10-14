#!/bin/bash

# ==============================================================================
# wasta-custom-mxb-postrm.sh
#
#   This script is automatically run by the postrm configure step on
#       removal of wasta-custom-mxb.  It can be manually re-run, but is
#       only intended to be run at package removal.
#
#   2015-09-19-06 rik: initial script
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
echo "*** Beginning wasta-custom-mxb-postrm.sh"
echo

# insert remove logic for keyboards here

# ------------------------------------------------------------------------------
# Finished
# ------------------------------------------------------------------------------

echo
echo "*** Finished with wasta-custom-mxb-postrm.sh"
echo

exit 0
