FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client cmake

WORKDIR /sigla

COPY Gemfile /sigla/Gemfile
COPY Gemfile.lock /sigla/Gemfile.lock

RUN gem install bundler
RUN bundle update --bundler && bundle install

COPY . /sigla

EXPOSE 3000

CMD [ "rails", "s" ]
