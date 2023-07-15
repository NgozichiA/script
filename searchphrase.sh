#! /bin/bash
# Count the number of failed logins by IP address
#if there are any IPs with over limite   , display the count, ip and location


LIMIT='10'
LOG_FILE="{1}"

#Make sure a file was supplied as an argument
if [[ ! -e "${LOG_FILE}" ]]
then 
	echo " cannot open log file: ${LOG_FILE}" >&2
	exit 1
fi
#Display the CSV header
echo 'Count, IP, Location'

#Loop throug the list of failed attempts and corresponding IP addresses

grep Failed systlog-sample | awk '{print $(NF - 3)}' | sort | uniq -c | sort -nr | while read COUNT IP
do

# if the number of failed attempts is greater than the limit, display count, ip and location
if [[ "${COUNT}" -gt "${LIMIT}" ]]
then 
	LOCATION=$(geoiplookup ${IP} | awk -F ',' ' {print $2}')
	echo "${COUNT}, ${IP}, ${LOCATION}"
fi
done
exit 0

#you need to provide a path like this example ./sample.sh  access_log
