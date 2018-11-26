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

COMPOSER_VENDOR_DIR="$(composer config vendor-dir 2> /dev/null)"
if [ -z "$COMPOSER_VENDOR_DIR" ]
then
  echo -e "${FG_C}${EBG_C} ERROR ${NO_C} Unable to locate find the composer project: 'composer config vendor-dir'"
  exit 1
fi
export DRUSH="$DEST_DIR/$COMPOSER_VENDOR_DIR/drush/drush/drush"
$DRUSH status > /dev/null
if [ $? -ne 0 ]; then
  echo -e "${FG_C}${EBG_C} ERROR ${NO_C} Drush is required to install Contenta CMS. Please install Contenta CMS using Composer. See http://www.contentacms.org/#install"
  exit 5
fi
DOCROOT="web"

echo "-----------------------------------------------"
echo " Installing Contenta CMS for local usage "
echo "-----------------------------------------------"
echo -e "${FG_C}${BG_C} EXECUTING ${NO_C} $DRUSH site-install contenta_jsonapi --verbose --yes \\
  --root=$DEST_DIR/$DOCROOT \\
  --db-url=$DB_URL_REDACTED \\
  --site-mail=$SITE_MAIL \\
  --account-mail=$ACCOUNT_MAIL \\
  --site-name=$SITE_NAME \\
  --account-name=$ACCOUNT_NAME \\
  --account-pass=\"[REDACTED]\";\n\n"

$DRUSH site-install contenta_jsonapi --verbose --yes \
  --root=$DEST_DIR/$DOCROOT \
  --db-url=$DB_URL \
  --site-mail=$SITE_MAIL \
  --account-mail=$ACCOUNT_MAIL \
  --site-name=$SITE_NAME \
  --account-name=$ACCOUNT_NAME \
  --account-pass="$ACCOUNT_PASS";

if [ $? -ne 0 ]; then
  echo -e "${FG_C}${EBG_C} ERROR ${NO_C} The Drupal installer failed to install Contenta CMS."
  exit 3
fi


mkdir -p $DEST_DIR/$DOCROOT/sites/default/files/tmp;

echo -e "${FG_C}${BG_C} EXECUTING ${NO_C} $DRUSH en -y recipes_magazin contentajs\n\n"
$DRUSH en -y recipes_magazin contentajs

echo -e "${FG_C}${BG_C} 🎉 ${NO_C} Contenta CMS was installed! Your admin password is: $ACCOUNT_PASS\n\n"
