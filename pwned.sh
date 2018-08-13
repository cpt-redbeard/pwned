#!/bin/bash

input="/path/to/txt/file"
while IFS= read -r pwned
do
#output for each email address
   echo ####
   echo "Processing $pwned..."
   echo ####
#html response code for pwned
owned="200"

#curl to get status
pwned_verdict=$(curl -s -o /dev/null -w "%{http_code}" "https://haveibeenpwned.com/api/v2/breachedaccount/""$pwned""?truncateResponse=true")
   #sleep is meant to not overload the API
sleep 2
pwned_reason=$(curl -s -A 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36 OPR/38.0.2220.41' "https://haveibeenpwned.com/api/v2/breachedaccount/""$pwned""?truncateResponse=true")
echo "$pwned_reason"


if [ "$pwned_verdict" == "$owned" ]
then
echo "$pwned" "has been pwned."
else
echo "$pwned" "is good to go."
fi

   echo ####
   #echo ####
   #sleep is meant to not overload the API
   sleep 2

done < "$input"