#!/bin/bash

###############################################
# This script need install [amass, asn] tools
# notic: enter company name, not company domain

args=("$@")
if [ -z ${args[0]} ];then
printf "%s\n\n\e[31m Please enter company name: \e[0m" ; read -p '' comapnyName
else
comapnyName=$1
fi

if [ -z ${args[1]} ];then
printf "%s\n\n\e[31m Please enter results file: \e[0m" ; read -p '' results
else
results=$2
fi

cidr_func () {
	printf "%s\n\e[31m========================================\n Extracting CIDR $comapnyName in -> $results \n========================================\n\e[0m\n"
	touch $results
	amass intel -org $comapnyName | cut -d , -f 1 > .asn
	for asn in $(cat .asn)
	do
	whois -h whois.radb.net -- "-i origin AS$asn" | grep -Eo "([0-9.]+){4}/[0-9]+" | sort -u >> $results
	cat $results
	done;
}

cidr_func
rm -r .asn;
printf "%s\n\e[31m CIDR Count --> " && cat $results | wc -l && printf " in File $results \n\e[0m\n"
