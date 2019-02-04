#!/bin/ash
for key in $KEYS; do 
    [ ! -f /var/lib/ssh/$key ] && ssh-keygen -t rsa -N "" -f /var/lib/ssh/$key > /dev/null;
    echo "Public key for [$key]:";
    cat /var/lib/ssh/$key.pub;
done