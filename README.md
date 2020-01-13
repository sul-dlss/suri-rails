[![Build Status](https://circleci.com/gh/sul-dlss/suri_rails.svg?style=svg)](https://circleci.com/gh/sul-dlss/suri_rails)
[![Test Coverage](https://api.codeclimate.com/v1/badges/8c69820c161e14d45bc9/test_coverage)](https://codeclimate.com/github/sul-dlss/suri_rails/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/8c69820c161e14d45bc9/maintainability)](https://codeclimate.com/github/sul-dlss/suri_rails/maintainability)
[![Docker image](https://images.microbadger.com/badges/image/suldlss/suri-rails.svg)](https://microbadger.com/images/suldlss/suri-rails "Get your own image badge on microbadger.com")

# SURI

SURI is the Stanford Libraries' Unique Resource Identifier minting system. It mints unique DRUIDs.

This is currently used for running specs;  we still use https://github.com/sul-dlss/suri2 in deployed environments.

## Requirements

1. Ruby (2.6.4 or greater)

## Installation

Clone the repository

    $ git clone git@github.com:sul-dlss/suri_rails.git

Change directories into the app and install dependencies

    $ bundle install

Start the development server

    $ rails s

## Testing

The test suite (with RuboCop style enforcement) will be run with the default rake task (also run on CI).

    $ rake

The specs can be run without RuboCop enforcement

    $ rake spec

The RuboCop style enforcement can be run without running the tests

    $ rake rubocop

## Building for Docker

```shell
$ docker build -t suldlss/suri-rails:latest .
```

Then run as:
```shell
$ docker run -d -p 127.0.0.1:3002:3000 suldlss/suri-rails:latest
```

Note that CI is configured to automatically update the image hosted on DockerHub on every commit to `master`.
