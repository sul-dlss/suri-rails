[![Build Status](https://circleci.com/gh/sul-dlss/suri-rails.svg?style=svg)](https://circleci.com/gh/sul-dlss/suri-rails)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ea20a9aca677b13896a0/test_coverage)](https://codeclimate.com/github/sul-dlss/suri-rails/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/ea20a9aca677b13896a0/maintainability)](https://codeclimate.com/github/sul-dlss/suri-rails/maintainability)
[![Docker image](https://images.microbadger.com/badges/image/suldlss/suri-rails.svg)](https://microbadger.com/images/suldlss/suri-rails "Get your own image badge on microbadger.com")
[![OpenAPI Validator](http://validator.swagger.io/validator?url=https://raw.githubusercontent.com/sul-dlss/suri-rails/main/openapi.yml)](http://validator.swagger.io/validator/debug?url=https://raw.githubusercontent.com/sul-dlss/suri-rails/master/openapi.yml)

# SURI

SURI is the Stanford Unique Resource Identifier service. It mints unique identifiers (e.g., DRUIDs).

SURI has an [OpenAPI 3.0 spec](http://spec.openapis.org/oas/v3.0.2) that documents the API in [openapi.yml](openapi.yml). You can browse the generated documentation at [http://sul-dlss.github.io/suri-rails/](http://sul-dlss.github.io/suri-rails/).

NOTE: This is currently used for running specs; we still use https://github.com/sul-dlss/suri2 in deployed environments. This will replace suri2 in Q2 2020.

## Requirements

1. Ruby (2.7.0 or greater)

## Installation

Clone the repository

    $ git clone git@github.com:sul-dlss/suri-rails.git

Change directories into the app and install dependencies

    $ bundle install

Start the development server

    $ rails s

## Testing

First, ensure the database container is spun up:

    $ docker-compose up db # use -d to daemonize/run in background

And if you haven't yet prepared the test database, run:

    $ bin/rails db:setup

The test suite (with RuboCop style enforcement) will be run with the default rake task (also run on CI).

    $ bin/rake

The specs can be run without RuboCop enforcement

    $ bin/rake spec

The RuboCop style enforcement can be run without running the tests

    $ bin/rake rubocop

## Building for Docker

Spin up the application and its database:

    $ docker-compose up --build

## Updating Docker Image

Note that CI is configured to automatically update the image hosted on DockerHub on every commit to `master`. If you want to build and push an image manually, run:

    $ docker build -t suldlss/suri-rails:latest .
    $ docker push suldlss/suri-rails:latest
