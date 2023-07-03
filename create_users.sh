# This scripts createds an account on the local system.
# You will be prompted for the account name and password
#Ask for the user name, real name, password
read -p 'Enter the username to create: ' USERNAME
read -p 'Enter the name of the person who owns the account: ' COMMENT
read -p 'Enter the password for this account: ' PASSWORD
#Create the user, set the password for the user

useradd -c "${COMMENT}" -m "${USERNAME}"
echo ${PASSWORD} | passwd --stdin ${USERNAME}
#Force password change on first login
passwd -e ${USERNAME}
