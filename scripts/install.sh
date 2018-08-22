#!/usr/bin/env bash

if [ -z "$DB_URL" ]
then
  echo -e "${FG_C}${EBG_C} ERROR ${NO_C} Unable to locate the database connection details. Did you forget to create the .env file?\n"
  exit 1
fi

# Define the color scheme.
FG_C='\033[1;37m'
BG_C='\033[42m'
WBG_C='\033[43m'
EBG_C='\033[41m'
NO_C='\033[0m'

COMPOSER_BIN_DIR="$(composer config bin-dir 2> /dev/null)"
if [ -z "$COMPOSER_BIN_DIR" ]
then
  echo -e "${FG_C}${EBG_C} ERROR ${NO_C} Unable to locate find the composer project: 'composer config bin-dir'"
  exit 1
fi
if [ $1 ] ; then
  DEST_DIR=$1
else
  DEST_DIR=$(pwd)
  echo -e "${FG_C}${WBG_C} WARNING ${NO_C} No install path was provided. Using the current directory: $DEST_DIR"
fi
DRUSH="$DEST_DIR/$COMPOSER_BIN_DIR/drush"
$DRUSH status > /dev/null
if [ $? -ne 0 ]; then
  echo -e "${FG_C}${EBG_C} ERROR ${NO_C} Drush is required to install Contenta CMS. Please install Contenta CMS using Composer. See http://www.contentacms.org/#install"
  exit 5
fi
DOCROOT="web"

echo "-----------------------------------------------"
echo " Installing Contenta CMS for local usage "
echo "-----------------------------------------------"
echo -e "${FG_C}${BG_C} EXECUTING ${NO_C} $DRUSH site-install --verbose --yes \\\n
  --root=$DEST_DIR/$DOCROOT \\\n
  --db-url=sqlite://$SQLITE_PATH/$SQLITE_DATABASE \\\n
  --site-mail=$SITE_MAIL \\\n
  --account-mail=$ACCOUNT_MAIL \\\n
  --site-name=$SITE_NAME \\\n
  --account-name=$ACCOUNT_NAME \\\n
  --account-pass=$ACCOUNT_PASS;\n\n"

# There is a problem installing from CLI. Drush can't locate some required services. Reinstalling a
# second time usually does the trick.
$DRUSH site-install --verbose --yes \
  --root=$DEST_DIR/$DOCROOT \
  --db-url=sqlite://$SQLITE_PATH/$SQLITE_DATABASE \
  --site-mail=$SITE_MAIL \
  --account-mail=$ACCOUNT_MAIL \
  --site-name=$SITE_NAME \
  --account-name=$ACCOUNT_NAME \
  --account-pass=$ACCOUNT_PASS;
$DRUSH site-install --verbose --yes \
  --root=$DEST_DIR/$DOCROOT \
  --db-url=sqlite://$SQLITE_PATH/$SQLITE_DATABASE \
  --site-mail=$SITE_MAIL \
  --account-mail=$ACCOUNT_MAIL \
  --site-name=$SITE_NAME \
  --account-name=$ACCOUNT_NAME \
  --account-pass=$ACCOUNT_PASS;

if [ $? -ne 0 ]; then
  echo -e "${FG_C}${EBG_C} ERROR ${NO_C} The Drupal installer failed to install Contenta CMS."
  exit 3
fi

echo -e "${FG_C}${BG_C} EXECUTING ${NO_C} $DRUSH en -y recipes_magazin contentajs\n\n"
$DRUSH en -y recipes_magazin contentajs contenta_graphql

echo -e "${FG_C}${BG_C} 🎉 ${NO_C} Contenta CMS was installed! Your admin password is: $ACCOUNT_PASS\n\n"
