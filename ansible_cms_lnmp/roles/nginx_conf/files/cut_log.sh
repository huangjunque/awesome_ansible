#!/bin/bash

#define and create log directory
error_log_path="/data/error_log/"
access_log_path="/data/access_log/"
error_log_dir=${error_log_path}$(date -d "yesterday" +"%Y")/$(date -d "yesterday" +"%m")
access_log_dir=${access_log_path}$(date -d "yesterday" +"%Y")/$(date -d "yesterday" +"%m")

mkdir -p $error_log_dir > /dev/null 2>&1
mkdir -p $access_log_dir > /dev/null 2>&1

#cut nginx error log
for  log_files_name in `ls -l /data/logs/ | grep -v ^d | awk -F' ' '{print $9}' | grep error |sed 's/.log//g'` 
do
mv /data/logs/$log_files_name.log ${error_log_dir}/$log_files_name\_$(date -d "yesterday" +"%Y%m%d").log
done

#cut nginc access log if exists
for  log_files_name in `ls -l /data/logs/ | grep -v ^d | awk -F' ' '{print $9}' | grep -v error |sed 's/.log//g'`
do
mv /data/logs/$log_files_name.log ${access_log_dir}/$log_files_name\_$(date -d "yesterday" +"%Y%m%d").log
done

#delete access log 7days before and error log 30days before
find $access_log_path -type f -mtime +7 -exec rm -rf {} \; 
find $error_log_path -type f -mtime +30 -exec rm -rf {} \; 

#nginx renew log file
pid=`find / -name nginx.pid -exec cat {} \;`

kill -USR1 $pid
