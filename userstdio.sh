#! /bin/bash

#This script creates a new user on the local system
#you must supply a username as an argument to the script, provide a comment for the account as an argument.
#A passwrod will be automatically generated for the account
#The username, password, and host for the account will be displayed.



#How to run it, you use it to create one user at a time
#./userstdio.sh Martins (username) Martins Hughs(comment)

#Make sure the script is been executed with the superuser privileges
if [[ "${UID}" -ne 0 ]]
then 
	echo "Please switch to the root user accounts" >&2   #standard error

	exit 1
fi

#If they don't supply at least one argument, then give them help
if [[ "${#}" -lt 1 ]]
then
	echo "Usage: ${0} USERNAME [COMMENT]..."  >&2		# standard error
	# or echo " please provide a username
	echo 'Create an account on the local system with the name of USERNAME and a comment' >&2  	#standard error

	exit 1
fi


#The first parameter is the user name

USERNAME="${1}"

# The rest of the parameters are for the account comments
shift
Comments="${@}"

#Generate a password
PASSWORD=$(date +%s%N | sha256sum | head -c48)

#Create the user with the password
useradd -c "${COMMENT}" -m ${USERNAME} &> /dev/null   #standard output and standard error
#Check to see if the useradd command succeeded
#We don't want to tell the user that an account was created when it hasn't been created
if [[ "${?}" -ne 0 ]]
then
	echo 'The account could not be created.'  >&2  #standard error
	exit 1
fi

#set the password
echo ${PASSWORD} | passwd --stdin ${USERNAME} &> /dev/null

#check to see if the passwd command succeeded as well.
if [[ "${?}" -ne 0 ]]
then 
	echo 'The password for the account could not be set.' >&2  #standard error
	exit 1
fi

#Force password change at first login

passwd -e ${USERNAME} &> /dev/null

#Display the username, password, and the host where the user was created.

echo

echo 'Username:'
echo "${USERNAME}"
echo
echo 'Password:'
echo "${PASSWORD}"
echo
echo 'host:'
echo "${HOSTNAME}"
exit 0


