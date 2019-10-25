#!/bin/bash

#set -x
FILENAME=$1

#grep ENDING 190710170717695300014_2.log | tail -n 1 | cut -d' ' -f5,6
printf "FILENAME: $FILENAME "

#STARTTIME=`grep run_start $FILENAME | head -n 1| cut -d' ' -f5,6,7`
STARTTIME=`grep run_start $FILENAME | head -n 1| cut -d' ' -f2`
#ENDTIME=`grep run_stop $FILENAME | tail -n 1| cut -d' ' -f5,6,7`
ENDTIME=`grep run_stop $FILENAME | tail -n 1| cut -d' ' -f2`

#date -d "2019-07-11 02:15:10" +"%s"
#STARTSEC=`date -d "$STARTTIME" +"%s"`
#ENDSEC=`date -d "$ENDTIME" +"%s"`

#SEC=$(echo $ENDSEC - $STARTSEC  |bc )
SEC=$(echo $ENDTIME - $STARTTIME  |bc )

echo "scale=4; $SEC / 60" | bc

#for file in `ls 190710*`; do ./results.sh $file; done | sort -n -k3

