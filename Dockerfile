FROM tjstlr2010/rails-api-server:latest
MAINTAINER JoungSik(tjstlr2010@gmail.com)

# Set working directory, where the commands will be ran:
WORKDIR /workspace

COPY Gemfile /workspace/Gemfile
COPY Gemfile.lock /workspace/Gemfile.lock

RUN gem install bundler
RUN bundle install --jobs 20 --retry 5 --without development test

ARG MASTER_KEY

ENV RAILS_ENV production
ENV RACK_ENV production
ENV RAILS_MASTER_KEY $MASTER_KEY

COPY . /workspace

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]