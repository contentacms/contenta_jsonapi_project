# Contenta JSON API Project

This repository is used in order to create a Contenta CMS project using Composer.

```
# Create the project in your local environment.
composer create-project contentacms/contenta-jsonapi-project cms.contentacms.local --stability dev --no-interaction

# Install Drupal.
cd cms.contentacms.local/web
drush si contenta_jsonapi \
  --db-url=mysql://db-user:db-password@localhost/db-name \
  --site-mail=admin@localhost \
  --site-name='Contenta CMS' \
  --account-mail=admin@localhost \
  --account-name=admin \
  --account-pass=admin -y
```

If you want documentation about Contenta CMS visit http://www.contentacms.org.
