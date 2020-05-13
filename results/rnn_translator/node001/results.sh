#!/bin/bash

#set -x
#echo "$1"
for file in $1
do 
    FILENAME=$file
    
    #grep ENDING 190710170717695300014_2.log | tail -n 1 | cut -d' ' -f5,6
    
    #STARTTIME=`grep run_start $FILENAME | head -n 1| cut -d' ' -f5,6,7`
    STARTTIME=`grep run_start $FILENAME | head -n 1| cut -d' ' -f2`
    #ENDTIME=`grep run_stop $FILENAME | tail -n 1| cut -d' ' -f5,6,7`
    ENDTIME=`grep run_stop $FILENAME | tail -n 1| cut -d' ' -f2`
    
    
    #date -d "2019-07-11 02:15:10" +"%s"
    #STARTSEC=`date -d "$STARTTIME" +"%s"`
    #ENDSEC=`date -d "$ENDTIME" +"%s"`
    
    #SEC=$(echo $ENDSEC - $STARTSEC  |bc )
    #for minigo
    if grep run_stop>/dev/null $FILENAME
    then
            SEC=$(echo $ENDTIME - $STARTTIME  |bc )
    else
            SEC=$(sed -n -e 's/^.*timestamp//p' $FILENAME | cut -d":" -f2 | cut -d"}" -f1 | cut -d"," -f1 )
    fi
    
    if [[ ! -z $SEC ]]
    then
        printf "FILENAME: $FILENAME "
        echo "scale=4; $SEC / 60" | bc 2>/dev/null
    fi
    #for file in `ls 200*`; do ./results.sh $file; done | sort -n -k3
done
