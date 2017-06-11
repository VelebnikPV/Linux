#!/bin/bash
cd /tmp/new

filler()
{
 str=$1
 num=$2

 temp=""
for (( c=1; c<=$num; c++ ))
do
    temp="$temp$str"
done
printf "%s" $temp
}

FILECOUNT=$(find $LOCATION -type f | wc -l)
SPIN=(— \\ \| /)

echo "PROCESS IS RUNNING..."
percents=0
spin_index=0
file_index=0;

tput civis      -- invisible
for f in $(find /tmp -name '*'); 
do 
	cp -r $f /tmp/trash 2>/dev/null;
	float_scale=2
	percents=$((file_index*100/FILECOUNT))
	spin_index=$(((i/10)%4))
	printf "\r%s" ${SPIN[$spin_index]}
    int_percents=$((percents/5))
	filler "▓" $int_percents
	filler "-" $((20-int_percents))
 	printf "  %.0f%s   %s" $percents % $file_index/$FILECOUNT
    i=$((i+1))
	file_index=$((file_index+1))
done
printf "\n%s\n" DONE!	
tput cnorm   -- normal
