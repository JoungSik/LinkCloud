FROM ruby:2.6.5
MAINTAINER JoungSik(tjstlr2010@gmail.com)

# Install dependencies
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn

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
RUN bundle install --jobs 20 --retry 5 --without development test

ARG MASTER_KEY

# ENV
ENV RACK_ENV production
ENV RAILS_ENV production
ENV RAILS_MASTER_KEY $MASTER_KEY

COPY . /workspace

RUN bundle exec rails assets:precompile

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
