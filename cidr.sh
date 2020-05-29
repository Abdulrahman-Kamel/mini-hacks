args=("$@")
if [ -z ${args[0]} ]
then
printf "%s\n\e[47m\e[31mPlease Enter Company Name\n\e[0m\n"
else
printf "%s\n\e[31m========================================\n= Extracting CIDR ${args[0]} in -> CIDR.txt =\n========================================\n\e[0m\n"
echo "" > CIDR.txt
amass intel -org ${args[0]} | cut -d , -f 1 > .asn
for asn in $(cat .asn)
do
whois -h whois.radb.net -- "-i origin AS$asn" | grep -Eo "([0-9.]+){4}/[0-9]+" | sort -u >> CIDR.txt
cat CIDR.txt
done;
rm -r .asn;
printf "%s\n\e[31mCIDR Count --> " && cat CIDR.txt | wc -l && printf "\n\e[0m\n"
fi
