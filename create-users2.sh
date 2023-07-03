#! /bin/bash

#This script creates a new user on the local system
#You will be prompted to enter the username (login), the person name, and a password
#The username, password, and host for the account will be displayed.

#Make sure the script is being executed with a superuser priviledges

if [[ "${UID}" -ne 0 ]]
then
	echo 'please run with sudo or as root.'
	exit 1
fi


#Get the username (login).
read -p 'Enter the username to create: ' USERNAME

#Get the real name
read -p 'Enter your official name on your account: ' COMMENT


#Get the password
read -p 'Enter the password to use for the account: ' PASSWORD

#create the account

useradd -c "${COMMENT}" -m "${USERNAME}"

#Check to see if the useradd command succeeded.

#We don't want to tell the user that an account was created when it hasn't been
if [[ "${?}" -ne 0 ]]
then
	echo 'The account could not be created'

	exit 1

fi


#SET the password
echo ${PASSWORD} | passwd --stdin ${USERNAME}

if [[ "${?}" -ne 0 ]] 
then
	echo 'The password for the account could not be created'
	exit 1
fi

# Force password change on first login
passwd -e ${USERNAME}


#Display the username, password, and the host where the user was created
echo
echo 'username:'
echo "${USERNAME}"
echo
echo 'password:'
echo "${PASSWORD}"
echo
echo 'host'
echo "${HOSTNAME}"

exit 0



