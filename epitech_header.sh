#!/bin/bash

if [ "$1" == "c" ]
then
	s="/*"
	m="**"
	e="*/"
elif [ "$1" == "m" ]
then
	s="##"
	m="##"
	e="##"
elif [ "$1" == "h" ]
then
	s="{-"
	m="--"
	e="-}"
fi


year=$(date | rev | cut -d " " -f1 | rev)
pname=$2

echo "$s"
echo "$m" "EPITECH PROJECT, $year"
echo "$m" $pname
echo "$m" "File description:"

awk -v line_head=$m '{printf "%s %s\n", line_head, $0}'

echo "$e"

