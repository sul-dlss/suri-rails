FROM ruby:3.2.2-alpine

LABEL maintainer="Stanford Libraries Infrastructure Team <dlss-infrastructure-team@lists.stanford.edu>"

RUN apk add --update --no-cache \
  build-base \
  git \
  postgresql-dev \
  postgresql-client \
  libxml2-dev \
  libxslt-dev \
  tzdata

RUN mkdir /app
WORKDIR /app

RUN gem update --system && \
  gem install bundler && \
  bundle config build.nokogiri --use-system-libraries

COPY Gemfile Gemfile.lock ./

RUN bundle config set without 'production' && bundle install

COPY . .

CMD ["./docker/invoke.sh"]
