#!/bin/bash
#
# Show server's certificate in a human-readable form.
#
#
#
domain="example.c"
port="443"
IFS='='                                                                              #Split the string '='

timeout 7 openssl s_client -connect $domain:$port > /dev/null 2>&1                   #Check conectivity to the server

if [[ $? == 124 || $? == 0 ]]; then                                                  #If the command upper return code is 124 or 0 the connection is successful
        date=$(openssl s_client -showcerts -connect $domain:$port < /dev/null  \
        2> /dev/null | openssl x509 -noout -enddate 2> /dev/null)                    #Export the end data of certificate
else
      echo "The certificate or host are not reachable"                               #If the code is differance from 124 or 0 the connection is unsuccessful
fi
read -a enddata <<<"$date"                                                           #Parse to string
echo "${enddata[1]}"                                                                 #Return data in readable format

