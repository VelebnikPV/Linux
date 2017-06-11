#!/bin/bash
cd /tmp
mkdir new
cd ./new

file_index=0
for i in {1..10}
do
	mkdir temp$i
	cd temp$i
	for j in {1..1500}
	do
		file_index=$((i*j+i))
		echo "This is the $file_index file" >> file$j
	done
	cd ../
done
echo "Done!"
