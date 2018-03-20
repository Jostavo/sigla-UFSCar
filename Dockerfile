FROM postgres
COPY backup.backup /docker-entrypoint-initdb.d/
FROM ruby:2.2.6
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /SiGLa
WORKDIR /SiGLa
COPY Gemfile /SiGLa/Gemfile
COPY Gemfile.lock /SiGLa/Gemfile.lock
RUN bundle install
COPY . /SiGLa
