#!/usr/bin/env bash

HOST_LABEL="([0-9a-zA-Z]|[0-9a-zA-Z][-0-9a-zA-Z]{0,61}[0-9a-zA-Z])"
IP_ADDR="(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])"
HOST="((($HOST_LABEL\.)+$HOST_LABEL)|(\[$IP_ADDR\]))"
LP_Chars="[-0-9a-zA-Z_.!#$%&'*+/=?^_\`{|}~]"
LOCAL="$LP_Chars+"
# if [ -f $1 ]; then
#     LIST=`cat $1 | grep -o -E "$LOCAL@$HOST" |sort|uniq`
# else
echo "Start!"
#for url1 in (url.txt)
#do
#    echo "${url}"
#done
filename='url.txt'
echo Start
while read url1; do
    echo $url1
#done < $filename
webpage=`wget -t2 -T2 -q -O- $url1`
if [ $? != "0" ]; then
    echo "Fail to get web page from $url1"
#    exit
fi
echo "try to get email"
LIST=`echo $webpage | grep -o -E "$LOCAL@$HOST" |sort|uniq`
for email in $LIST ; do
    # echo $email
    username=`echo $email|cut -d@ -f1`
    domain=`echo $email|cut -d@ -f2`
    echo "$email $username"
    echo "$email $username" >> emails.txt
done
done < $filename
