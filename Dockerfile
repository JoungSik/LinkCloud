FROM ruby:3.0.0
MAINTAINER JoungSik(tjstlr2010@gmail.com)

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Set an environment variable where the Rails app is installed to inside of Docker image:
RUN mkdir /run-data
RUN mkdir -p /workspace
RUN mkdir -p /workspace/tmp
RUN mkdir -p /workspace/tmp/pids
WORKDIR /workspace

COPY Gemfile /workspace/Gemfile
COPY Gemfile.lock /workspace/Gemfile.lock

# Gems:
RUN gem install bundler
RUN bundle config set force_ruby_platform true
RUN bundle install --jobs 20 --retry 5 --without development test

ARG MASTER_KEY

# ENV
ENV RACK_ENV production
ENV RAILS_ENV production
ENV RAILS_MASTER_KEY $MASTER_KEY

COPY . /workspace

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
