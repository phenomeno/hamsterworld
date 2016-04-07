#################################
# Dockerfile to run hamster_world
# Based on Ubuntu
#################################

FROM ubuntu
MAINTAINER Grace Lee <writegracelee@gmail.com>

WORKDIR /app
ADD . /app
RUN apt-get update
RUN apt-get -y --force-yes install ruby-full rubygems-integration
RUN gem install bundler
RUN bundle install --without test
EXPOSE 80

ENTRYPOINT ["ruby", "bin/app.rb"]
CMD [":production"]
