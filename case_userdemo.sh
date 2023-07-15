#! /bin/bash

#This script demostrates the case statement

if [[ "${1}" = 'Start' ]]
then 
	echo 'starting'
elif [[ "${1}" = 'stop' ]]
then
	echo 'stopping'
elif [[ "${1}" = 'status' ]]
then 
	echo 'Status'
else
	echo 'supply a valid option '  >&2
	exit 1
fi
	

