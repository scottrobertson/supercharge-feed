FROM ruby:2.6.1
WORKDIR /app

RUN apt-get update -qq && apt-get install -y build-essential libxml2-dev libxslt1-dev

RUN gem install bundler -v '1.16.6'
ADD Gemfile* /app/
RUN bundle install --jobs 4 --retry 1 --without development test

ADD . /app

# RUN bundle exec rake assets:precompile && rake stats
