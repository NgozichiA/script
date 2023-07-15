#!/bin/bash
logger "Backing up message log and secure log"
cp /var/log/messages /path/to/backup/
cp /var/log/secure /path/to/backup/

