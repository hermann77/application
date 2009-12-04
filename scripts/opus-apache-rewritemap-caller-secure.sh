#!/usr/bin/env sh
#
# This script is needed to make php forget session information between to requests.
# Also it makes the rewrite map more robust in case of php errors.

# please configure the next to lines
PHP='/usr/bin/php5'
MAP='/home/developer/workspace/bsz_opus_application/scripts/opus-apache-rewritemap.php'

THIS_UID="`/usr/bin/id -u`"
USER='www-data'

SU='/bin/su'
SUDO='/usr/bin/sudo'


# Every user-id below 10 is "magic" and shouldn't be used.
# Change this value to a reasonable value deppending your system settings.
if test "0$THIS_UID" -le 10; then

    # Decide which tool to choose.  "su" is more portable, but "sudo"
    # looks nicer in the process listing.
    # exec $SU -c "$0" $USER
    exec $SUDO -u $USER "$0"

	# exec should never return, so this is just to prevent passing
	exit
fi

# DO NOT CHANGES ANYTHING BELLOW THIS LINE, EXCEPT YOU REALLY KNOW WHAT YOU ARE DOING!
# keep this quite simple!
while read request
do
    echo `$PHP $MAP "$request"`
done
