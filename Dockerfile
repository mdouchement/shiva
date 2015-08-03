FROM ruby:2.2.2
MAINTAINER mdouchement

RUN mkdir -p /usr/src/app
RUN mkdir -p /data/storage
RUN mkdir -p /data/db
WORKDIR /usr/src/app

ENV RAILS_ENV production
ENV RACK_ENV production
ENV STORAGE_DIRECTORY /data/storage
ENV DATABASE_PATH /data/db/production.sqlite3

RUN mkdir -p tmp/pids
COPY . /usr/src/app
# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1
RUN bundle install --deployment --without development test

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN bundle exec rake assets:precompile

VOLUME /data/storage
VOLUME /data/db
EXPOSE 3000
CMD bundle exec rake db:migrate && \
    bundle exec rake indexer /data/storage && \
    SECRET_KEY_BASE=$(bundle exec rake secret) bundle exec unicorn -p 3000 -c config/unicorn.rb
