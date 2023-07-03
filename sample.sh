#! /bin/bash

#assign a value to a variable

WORD='Script'

#display that value using the variable
echo "$WORD"

#Demonstarte that single quotes cause variables to Not get expanded.
echo '$WORD'

#combine the variable with hard coded text
echo "This is a shell $WORD"

#Display the contents of the variable using alternative syntax
echo "This is a shell ${WORD}"

#Append text to the variable

echo "${WORD}ing is fun!"
 
#show how NOT to append text to a variable, this wont work

echo "$WORDing is fun!"

#Create a new variable
ENDING='ed'

echo "This is ${WORD}${ENDING}"


#Change the value stored in the ENDING Variable
ENDING='ing'

echo "${WORD}${ENDING} is fun!"

#Reassigning  value to ENDING

ENDING='s'

echo "You are going to write many ${WORD}${ENDING} in this class"
