#!/usr/bin/env bash

if [ $1 ] ; then
  DEST_DIR=$1
else
  DEST_DIR=$(pwd)
fi

if [ -e $DEST_DIR/.env ]; then
    export $(cat $DEST_DIR/.env | xargs)
fi
if [ -e $DEST_DIR/.env.local ]; then
    export $(cat $DEST_DIR/.env.local | xargs)
fi

DB_URL="sqlite://$SQLITE_PATH/$SQLITE_DATABASE"
./install.sh
