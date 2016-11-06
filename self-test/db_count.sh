#!/bin/bash
source .env
echo "Counts from $MYSQL_DATABASE.media-table"
docker exec -it naturalistdocker_db_1 mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "select count(*) from $MYSQL_DATABASE.media;"
