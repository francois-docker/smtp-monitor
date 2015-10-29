#! /bin/bash

function sendmail {
    export SUBJECT=ATTENTION: Mail has been sent to unknown address
    export SMTP=172.17.0.7:25
    export EMAIL=fbillant@gmail.com
    echo "WARNING: An email has been sent to the address: $1" | mailx -S smtp=$SMTP -s "$SUBJECT" "$EMAIL"
}

AUTHORIZED_ADDRESSES="/root/authorized_addresses.list"
ALREADY_SENT_ADDRESSES="/root/already_sent.list"
LOG=`docker logs smtp_gmail | grep RCPT | cut -d "<" -f 2 | cut -d ">" -f 1 | sort | uniq`

for ADDRESS in $LOG
do
    #If the address is not in the authorized_addresses list
    if ! grep -Fxq "$ADDRESS" "$AUTHORIZED_ADDRESSES"; then
        echo "this address: $ADDRESS is not authorized"

        #If the ip address has not laready be signaled by mail
        if ! grep -Fxq "$ADDRESS" "$ALREADY_SENT_ADDRESSES"; then
            echo "The mail regarding address: $ADDRESS is being sent"
            sendmail $ADDRESS
            sleep 3
            echo $ADDRESS >> $ALREADY_SENT_ADDRESSES
        fi
    fi
done

