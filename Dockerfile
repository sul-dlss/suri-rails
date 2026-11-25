# syntax=docker/dockerfile:1
# check=error=true

# Image used by other apps' compose / CI for integration testing.

ARG RUBY_VERSION=4.0.7
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

LABEL maintainer="Stanford Libraries Infrastructure Team <dlss-infrastructure-team@lists.stanford.edu>"

WORKDIR /app

# postgresql-client provides psql for docker/invoke.sh.
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y libjemalloc2 postgresql-client tzdata && \
    ln -s /usr/lib/$(uname -m)-linux-gnu/libjemalloc.so.2 /usr/local/lib/libjemalloc.so && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Runs in development: production forces SSL, which breaks plain-HTTP calls from other containers.
ENV RAILS_ENV="development" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development test deployment" \
    LD_PRELOAD="/usr/local/lib/libjemalloc.so"

# Throw-away build stage to reduce size of final image
FROM base AS build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libyaml-dev pkg-config libpq-dev && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY Gemfile Gemfile.lock ./
# bin/ binstubs activate the exact Bundler version from Gemfile.lock.
RUN gem install bundler -v "$(tail -1 Gemfile.lock | tr -d ' ')" && \
    bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

COPY . .

RUN bundle exec bootsnap precompile app/ lib/


# Final stage for app image
FROM base

RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash
USER 1000:1000

COPY --chown=rails:rails --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --chown=rails:rails --from=build /app /app

CMD ["./docker/invoke.sh"]
