FROM ruby:2.6.4-alpine


RUN apk update && apk add build-base sqlite-dev tzdata git

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.0.2
RUN bundle install

COPY . .

LABEL maintainer="Justin Coyne <jcoyne@justincoyne.com>"

CMD puma -C config/puma.rb