#! /bin/bash

#Display the top three most visited URLs for a given web server log file location to find it /var/log/httpd/access_log
# you must specify the path to run the command for example ./monitor_network access_log (this is how to run it to get your answers)


LOG_FILE="${1}"
if [[ ! -e "${LOG_FILE}" ]]  #if logfile does not exit, then give an error message
then 
	echo "cannot open ${LOG_FILE}" >&2
	exit 1
fi

cut -d '"' -f 2 ${LOG_FILE} | cut  -d ' ' -f 2 | sort | uniq -c | sort -n | tail -3
