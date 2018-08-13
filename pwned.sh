#!/bin/bash
clear


cat << eof
 _   _                   _____       
| | | |                 |_   _|      
| |_| | __ ___   _____    | |        
|  _  |/ _` \ \ / / _ \   | |        
| | | | (_| |\ V /  __/  _| |_       
\_| |_/\__,_| \_/ \___|  \___/                                                                               
 _                                   
| |                                  
| |__   ___  ___ _ __                
| '_ \ / _ \/ _ \ '_ \               
| |_) |  __/  __/ | | |              
|_.__/ \___|\___|_| |_|                                                                                      
                              _ ___  
                             | |__ \ 
 _ ____      ___ __   ___  __| |  ) |
| '_ \ \ /\ / / '_ \ / _ \/ _` | / / 
| |_) \ V  V /| | | |  __/ (_| ||_|  
| .__/ \_/\_/ |_| |_|\___|\__,_|(_)  
| |                                  
|_|                                  
eof


input="emails.txt"
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

if [ -z "$pwned_reason" ]
then
echo "***""$pwned_reason""***"
fi


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