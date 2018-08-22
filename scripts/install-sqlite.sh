#!/usr/bin/env bash

if [ $1 ] ; then
  export DEST_DIR=$1
else
  export DEST_DIR=$(pwd)
fi

if [ -e $DEST_DIR/.env ]; then
    export $(cat $DEST_DIR/.env | xargs)
fi
if [ -e $DEST_DIR/.env.local ]; then
    export $(cat $DEST_DIR/.env.local | xargs)
fi

export DB_URL="sqlite://$SQLITE_PATH/$SQLITE_DATABASE"
./$(dirname $0)/install.sh
