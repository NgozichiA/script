#! /bin/bash
#Description: user details app
#author: Ngozichi
#melto:
#date


echo "job type"
read
echo "Please put in your age"
read AGE

if ([ $AGE -gt 17 ] && [ $AGE -le 40 ])
then
        echo " You are go to go ahead with your job search"
sleep 2
else
        echo " you are not qualified for this job"
        exit 1
fi

echo "######################################################################"
echo "               Please begin the registration process"
echo "######################################################################"
echo
read -p "Last_Name              : "
echo
read -p "First_Name             : "
echo
read -p "State                  : "
echo
read -p "Middle_Name            : "
echo
read -p "Why did you leave your previous job            : "
echo
read -p "Why did you choose us                          :"
echo
read -p "What is your salary expectation                :"
echo
read -p "How soon can you start                         :"
echo
read -p "Do you have any other think we should know?    :"
echo
echo
sleep 5
echo "                           Information saved"
echo "#########################################################################"
read -p      "Thank you for choosing us, we will get back to you soon"
echo "########################################################################"

