#! /bin/bash

# This scripts generates a list of random password

#A random number as a password
PASSWORD="${RANDOM}"
echo "${PASSWORD}"

#Three random numbers together.

PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "${PASSWORD}"


#use the current date/time as the basis for the password
PASSWORD=$(date +%s)

echo "${PASSWORD}"

#use nanoseconds to act as randomization

PASSWORD=$(date +%s%N)
echo "${PASSWORD}"


# A better password

PASSWORD=$(date +%s%N | sha256sum | head -c32)
echo "${PASSWORD}"

#An even better password
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)

echo "${PASSWORD}"


#Append special character to a password

SPECIAL_CHARACTER=$(echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1)
echo "${PASSWORD}${SPECIAL_CHARACTER}"
