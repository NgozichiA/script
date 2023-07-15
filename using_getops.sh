#! /bin/bash

#This script generates a rando, password
#the user can set the password length with -l and add a special character wuth -S
#Verbose mode can be enabled with -v

#Set a default password length
#LENGTH=48

#while getopts vl:s OPTION    	#vl:s means that the -l option must be followed with the argument of its own, the OPTION is the variable name, you should
#do                              #use numbers to test it
#	case ${OPTION} in
#	v)
#	  VERBOSE='true'
#	  echo 'Verbose mode on'
#	  ;;
#	l)
#	   LENGTH="${OPTARG}"
#	  ;;
#	S)
#	   USE_SPECIAL_CHARACTER='true'
#	  ;;
#	?)
#	   echo 'Invalid option' >&2
#	 exit 1
#	 ;;
#	 esac
#done





usage() {                                                   #This part helps us such that if we run the script and put in an invalid letter not specified in
	echo "Usage: ${0} [-vs] [-l LENGTH]" >&2    #the script like x it will show us the options we should select from
	echo 'Generate a random password'
	echo ' -l LENGTH Specify the password length'
	echo ' -s Append a special character to the password'
	echo ' -v Increase Verbosity'
	exit 1
}

log(){
	local MESSAGE="${@}"
	if [[ "${VERBOSE}" = 'true' ]]
	then
		echo "${MESSAGE}"
	fi
}
#Set a default password length
LENGTH=48

while getopts vl:s OPTION       #vl:s means that the -l option must be followed with the argument of its own, the OPTION is the variable name, you should
do                              #use numbers to test it so if you put in an invalid argument like -x it will show you the list above in the echo statement
        case ${OPTION} in      # but test by doing echo $? if it shows 1 then the command did not execute as expected. use the right argument
        v)                     #you should test it also with -l 8 meaning print 8 characters pf passwordi
          VERBOSE='true'
          log 'Verbose mode on'
          ;;
        l)
           LENGTH="${OPTARG}"
          ;;
        s)
           USE_SPECIAL_CHARACTER='true'
          ;;
        ?)
           usage
        
         ;;
         esac
done

echo "Number of args: ${#}"    #test this by ./using-opts.sh -sl 8 extra stuff notice you have -sl 8 extra stuff store in ${@}
echo "All args: ${@}"         #-sl is stored in ${1} and 8 is stored in ${2} then extra stuff is stored in ${3}
echo "First arg: ${1}"
echo "Second arg: ${2}"
echo "Third arg: ${3}"

#inpsect OPTIND
echo "OPTIND: ${OPTIND}"

#Remove the options while leaving the remaining arguments.
shift "$(( OPTIND -1))"

echo 'After the shift:'
echo "Number of args: ${#}"    #test this by ./using-opts.sh -sl 8 extra stuff notice you have -sl 8 extra stuff store in ${@}
echo "All args: ${@}"         #-sl is stored in ${1} and 8 is stored in ${2} then extra stuff is stored in ${3}
echo "First arg: ${1}"
echo "Second arg: ${2}"
echo "Third arg: ${3}"

if [[ "${#}" -gt 0 ]]
then
	usage
fi




log 'Generating a password'

PASSWORD=$(date +%s%N${RANDOM} | sha256sum | head -c${LENGTH}) #this generates a password

#Append a special character if requested to do so
if [[ "${USE_SPECIAL_CHARACTER}" = 'true' ]]
then
	log 'Selecting a randowm special character'.
	SPECIAL_CHARACTER=$(echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1)
	PASSWORD="${PASSWORD}${SPECIAL_CHARACTER}"
fi

	log 'Done'
	log 'Here is the password'

#Display the Password
	echo "${PASSWORD}"
	exit 0
