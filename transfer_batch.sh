#!/bin/bash

#batch=$1 # only command line argument is batch
# Provide second directory argument if not in default dir
if [ $# -eq 1 ] ; then
    batch=$1
    adaptDir="/att/nobackup/mwooten3/AIST/TTE/ASP"
fi
if [ $# -eq 2 ] ; then
    batch=$1
    adaptDir=$2
fi

tarzipBatch=false # set to true if batch was tar/zipped

logfile="/att/nobackup/mwooten3/AIST/TTE/queryLogs/batch${batch}_ADAPT_query_log.txt"

printf "\nCopying archive to DISCOVER with rsync. Output can be found in:\n$logfile\n\n"

exec >> $logfile 2>&1 # redirect standard out and error to log file

SECONDS=0


printf "\n-------------------------------------------"
printf "\nCopying archive to DISCOVER with rsync:\n\n"
printf "START: "
#start_date=date
date
#printf "\n"
if [ "$tarzipBatch" = true ] ; then
    cmd="nohup rsync -avxH --progress $adaptDir/batch$batch-archive.tar.gz discover.nccs.nasa.gov:/discover/nobackup/projects/boreal_nga/ASP" # if using tar.gz
else
    cmd="nohup rsync -avxH --progress $adaptDir/batch$batch  discover.nccs.nasa.gov:/discover/nobackup/projects/boreal_nga/ASP"
fi
printf " $cmd\n\n"
eval $cmd
printf "\n\nEND: "
#end_date=date
#printf "$end_date"
date
duration=$SECONDS
printf "\nElapsed time to move batch $batch archive = $(($duration/60)) minutes\n\n"
