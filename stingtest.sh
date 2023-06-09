#Display the UID and username of the user executing this script.
#Display if the user id is the root user or not

#Display the UID
echo "your UID is ${UID}"

#Display if the UID does not match 1000
UID_TO_TEST_FOR= '1000'
if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then
	echo "Your UID does not match ${UID_TO_TEST_FOR}"
	exit 1

fi

#DISPLAY the username
USERNAME=$(id -un)


#Test if the command succeeded
if [[ "${?}" -ne 0 ]] 
then 
	echo "The command did not execute successfully"
	exit 1
fi
echo "your username is ${USERNAME}"

#You can use a string test conditional
USER_NAME_TO_TEST_FOR='root'
if [[ "${USERNAME}" = "${USER_NAME_TO_TEST_FOR}" ]]
then 
	echo "your username matches ${USER_NAME_TO_TEST_FOR}"
fi

#Test for ! = (not equal) for the string
if [[ "${USERNAME}" != "${USER_NAME_TO_TEST_FOR}" ]]
then

	echo "your username does not match ${USER_NAME_TO_TEST_FOR}"
	exit 1

fi

exit 0

