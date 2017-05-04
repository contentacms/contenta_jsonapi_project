# Usage

* Installs the Drupal site, for example via
```
api_first/development/build-api-first.sh
```
* Log into drupal and client a oauth client on ```/admin/config/people/simple_oauth/oauth2_client/add```
* Copy ```example.env``` to ```.env``` and adapt the values.
* Get started.

## Generate stuff

Generator usage:

```
cd cli
node generator-form.js node
```

This folder provides a couple of generators which lets you get started with
building a decoupled Drupal site:

* generator-form: This generates a working form component from a given entity type, bundle and form mode
* generator-view: This generates a working view component from a given entity type, bundle and view mode

It leverages some mapping between formatters/widgets and react components placed defined in ```form.mapping.json```
and ```view.mapping.json```.


## Installation profile usage
Use see "api_first/README.md"

## TODOs

- Find better name
- Use a proper template engine (markup-js is sad)
- Provide complete form state management

- Support multivalue fields in view
- Support multivalue fields in form

- Provide view and form components for much more components.

- more ...
- Use some eslint configuration

## Development

- todo

