#!/bin/bash
basepath=$(dirname $(readlink -f $0))

if [ ! -f "$1" ]
then
	touch "$1"
fi

pname=$2
if [[ $# < 2 ]]
then
	pname=$(basename $1)
fi

if [[ "$1" == *".c" || "$1" == *".h" || "$1" == *".cpp" || "$1" == *".hpp" ]]
then
	mode="c"
elif [[ "$1" == *".hs" ]]
then
	mode="h"
elif [[ "$1" == "Makefile" ]]
then
	mode="m"
else
	echo "Not valid file name"
	exit
fi

echo "Write the description(ctrl+d to end):"
$basepath/epitech_header.sh $mode "$pname" | cat - "$1" > "$1.temp"
mv "$1.temp" "$1"
