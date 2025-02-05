FROM ruby:3.2

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  imagemagick \
  libpq-dev \
  nodejs \
  npm
  
RUN mkdir -p /src/app

WORKDIR /src/app

COPY Gemfile Gemfile.lock /src/app/

RUN bundle install

COPY . /src/app/

RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0"]