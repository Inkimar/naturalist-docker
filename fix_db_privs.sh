#!/bin/bash
USER=root
PASS=supersecret
HOST=127.0.0.1
mysql -u $USER -p$PASS -h $HOST -e "grant all on *.* to 'naturalist'@'%';"
mysql -u $USER -p$PASS -h $HOST -e "grant all on *.* to 'naturalist'@'localhost';"
mysql -u $USER -p$PASS -h $HOST -e "flush privileges;"
