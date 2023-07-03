#! /bin/bash

# Display the UID
echo "your UID is ${UID}"

#Display Username
#you can do USERNAME=`id -un`
USERNAME=$(id -un)
echo "your name is ${USERNAME}"
#Display if the user is the root user or not
#this command can also be written this way
#if [["${UID}" -eq 0]]; then echo 'You are root'; else echo 'you are not a root'

if [[ "${UID}" -eq 0 ]]
then
	echo 'You are root.'
else
	echo 'You are not root.'

fi


