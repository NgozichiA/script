#! /bin/bash

#how to use the Case keyword in your script

case "${1}" in
	start)
	echo 'starting'
	;;
	stop)
	echo 'stopping'
	;;
	status|state|--status|--state)
	echo 'status'
	;;
	*)
	echo 'Supply a valid option' >&2
	exit 1
		;;
esac
