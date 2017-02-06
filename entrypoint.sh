#!/bin/sh
# ----------------------------------------------------------------------------
# entrypoint for container
# ----------------------------------------------------------------------------
set -e

HOST_IP=`/bin/grep $HOSTNAME /etc/hosts | /usr/bin/cut -f1`
export HOST_IP=${HOST_IP}

echo
echo "container started with ip: ${HOST_IP}..."
echo

if [ "$1" == "tideways-daemon" ]; then
	echo "starting tideways-daemon, with: ${TIDEWAYS_DAEMON_EXTRA}"
	/usr/bin/tideways-daemon $TIDEWAYS_DAEMON_EXTRA
elif [ "$1" == "bash" ] || [ "$1" == "shell" ]; then
	echo "starting /bin/bash with /etc/profile..."
	/bin/bash --rcfile /etc/profile
else
	echo "Running something else ($@)"
	exec "$@"
fi
