#!/usr/bin/env bash

if [ $1 ] ; then
  export DEST_DIR=$1
else
  export DEST_DIR=$(pwd)
fi

if [ -e $DEST_DIR/.env ]; then
    export $(grep -v '^#' $DEST_DIR/.env | grep -v '^$' | xargs)
fi
if [ -e $DEST_DIR/.env.local ]; then
    export $(grep -v '^#' $DEST_DIR/.env.local | grep -v '^$' | xargs)
fi

export DB_URL="mysql://$MYSQL_USER:$MYSQL_PASSWORD@$MYSQL_HOSTNAME:$MYSQL_PORT/$MYSQL_DATABASE"
export DB_URL_REDACTED="mysql://$MYSQL_USER:[REDACTED]@$MYSQL_HOSTNAME:$MYSQL_PORT/$MYSQL_DATABASE"
./$(dirname $0)/install.sh
