#! /bin/bash

#functions to log info to the system log

#How to define a function method number one
#log() {
#	echo 'you called the log function'
#}

#log


#How to define a function method number two
#function log {
#        echo 'you called the log function'
#}

#log


#Another example
#log() {
#	local MESSAGE="${@}"
#	if [[ "${VERBOSE}" = 'true' ]]
#	then

 #       echo "${MESSAGE}"
#	fi
#}

#log 'Hello'
#VERBOSE='true'
#log 'This is fun'


#Another example
#log() {
#       local VERBOSE="${1}"
#       shift
#       local MESSAGE="${@}"
#       if [[ "${VERBOSE}" = 'true' ]]
#       then

#       echo "${MESSAGE}"
#       fi
#}
#VERBOSITY='true'
#log "${VERBOSITY}" 'Hello'

#log "${VERBOSITY}" 'This is fun'


# This function sends a message to syslog (/var/log/messages) and to standard outpu if VERBOSE is true
log() {                                      #This is a function
           
       local MESSAGE="${@}"
       if [[ "${VERBOSE}" = 'true' ]]
       then

       echo "${MESSAGE}"
       fi
       logger -t usingfunction.sh "${MESSAGE}"   #When the below messages are displayed it will be logged in /var/log/messages 
}

backup_file() {                  #This function creates a backup of a file. Returns non-zero status on error
 	local FILE="${1}"

	if [[ -f "${FILE}" ]]
	then 
	    local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
	log "backing up ${FILE} to ${BACKUP_FILE}"

	cp -p ${FILE} ${BACKUP_FILE}   #The exit status of the function will be exit status of the cp command, the cp -p will return the acutal date of
					#the file not the current date on which the back up was being made

	else
	return 1       #The file does not exist, return a non-zero exit status

	fi
}

readonly VERBOSE='true'    #if your VERBOSE is set to false, the below won't print but the below will be logged in /var/log/messages
log  'Hello'

log  'This is fun'


backup_file '/etc/passwd'   #you are backing up the /etc/passwd file once you run this script you should check /var/log/messages and see the log there
			   #Also when you go to /var/tmp you should see the back up there


if [[ "${?}" -eq '0' ]]     #This makes a decision based on the exit status of the function
then
	log 'File backup succeeded'
else
	log 'File backup failed'
	exit 1
fi
