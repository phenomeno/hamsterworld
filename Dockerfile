#################################
# Dockerfile to run hamster_world
# Based on Ubuntu
#################################

FROM ruby:2.1
MAINTAINER Grace Lee <writegracelee@gmail.com>

WORKDIR /app
ADD . /app
ENV RACK_ENV production
RUN apt-get update
RUN gem install bundler
RUN bundle install --without development
EXPOSE 8080

ENTRYPOINT ["ruby", "bin/app.rb"]
