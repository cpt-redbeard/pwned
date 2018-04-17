#!/bin/bash
for pwned in $(cat emails.txt)
do
	echo ####
   echo "Processing $pwned..."
   #echo ####
   #setting owned to a successful response to compare later
owned="200"
#quotes were incorrect in the curl command, it wasn't passing it the email, it was passing $pwned as the value. Very tricky
pwned_verdict=$(curl -s -o /dev/null -w "%{http_code}" 'https://haveibeenpwned.com/api/v2/breachedaccount/'$pwned'?truncateResponse=true')

#used to debug what the status was after the curl
#echo $pwned_verdict

if [ $pwned_verdict == $owned ]
then
echo $pwned "has been pwned."
else
echo $pwned "is good to go."
fi

   echo ####
   echo ####
   sleep 2

done