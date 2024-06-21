FROM ruby:3.3.1-bookworm

LABEL maintainer="Stanford Libraries Infrastructure Team <dlss-infrastructure-team@lists.stanford.edu>"

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        postgresql-client postgresql-contrib libpq-dev \
        libxml2-dev libxslt-dev git tzdata

RUN mkdir /app
WORKDIR /app

RUN gem update --system && \
  gem install bundler && \
  bundle config build.nokogiri --use-system-libraries

COPY Gemfile Gemfile.lock ./

RUN bundle config set without 'production' && bundle install

COPY . .

CMD ["./docker/invoke.sh"]
