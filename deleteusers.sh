#!/bin/bash

#This scripts disables, deletes and /or archives user on the local system

#Make sure the script is being executed with super privileges


ARCHIVE_DIR='/archive'

usage() {
#Display the usage and exit.
echo "Usage: ${0} [-dra] USER [USERNAME]..." >&2
echo 'Disable a local Linux account' >&2
echo ' -d Deletes accounts instead of diabling them' >&2
echo ' -r Removes the home directory associated with the account(s)' >&2
echo ' -a Creates an archive of the home directory associated with the account(s)' >&2
exit 1

}

if [[ "${UID}" -ne 0 ]]
then
	echo 'Please run with sudo or as a root ' >&2
	exit 1
fi


# parse the options
while getopts dra OPTION
do
	case ${OPTION} in
	d) DELETE_USER='true' ;;
	r) REMOVE_OPTION='-r' ;;
	a) ARCHIVE='true' ;;
	?) usage ;;
        esac
done

#Remove the options while leaving the remaining arguments
shift "$(( OPTIND - 1))"

#If the user doesn't supply at least one argument, give them help

if [[ "${#}" -lt 1 ]]
then
	usage
fi

#Loop through all the usernames supplied as arguments.
for USERNAME in "${@}"
do
	echo "Processing user: ${USERNAME}"
#make sure the UID of the account is at least 1000.
USERID=$(id -u ${USERNAME})
if [[ "${USERID}" -lt 1000 ]]
then
	echo "Refusing to remove the ${USERNAME} account with UID ${USERID} " >&2
	exit 1
fi

#Create an archive if requested to do so
if [[ "${ARCHIVE}" = 'true' ]]
then

#Make sure the ARCHIVE_DIR directory exits.
if [[ ! -d "${ARCHIVE_DIR}" ]]     #this part says if there is no archive_dir then created it help test you can see the meaning of ! expr etc
then 
	echo "Creating ${ARCHIVE_DIR} directory"
	mkdir -p ${ARCHIVE_DIR}
	if [[ "${?}" -ne 0 ]]
	then
		echo "The archive directory ${ARCHIVE_DIR} could not be created. " .&2
		exit 1
	fi
fi

#Archive the user's home directory and move it into the ARCHIVE_DIR
HOME_DIR="/home/${USERNAME}"
ARCHIVE_FILE="${ARCHIVE_DIR}/${USERNAME}.tgz"
if [[ -d "${HOME_DIR}" ]]
then
	echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
	tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
	if [[ "${?}" -ne 0 ]]
	then
		echo "Could not create ${ARCHIVE_FILE}." >&2
		exit 1
	fi

	else
		echo "${HOME_DIR} does not exist or is not a directory." >&2
		exit 1
	fi

fi


if [[ "${DELETE_USER}" = 'true' ]]
then
	#delete the user
	userdel ${REMOVE_OPTION} ${USERNAME}

	#check to see if the userdell command suceeded.
	#we dont want the user to think the account got deleted when it did not get deleted

	if [["${?}" -ne 0 ]]
	then 
		echo "The account ${USERNAME} was NOT deleted" >&2
		exit 1
	fi
	echo "The account ${USERNAME} was deleted"

else
	chage -E 0 ${USERNAME} 

	#Check to see if the chage command succeeded
	 #we dont want the user to think the account got deleted when it did not get deleted
       if [["${?}" -ne 0 ]]
        then
                echo "The account ${USERNAME} was NOT deleted" >&2
                exit 1
        fi
        echo "The account ${USERNAME} was disabled"

fi
done
exit 0




