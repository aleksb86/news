FROM ruby:2.6.2-stretch

RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/c\#deb http:\/\/deb.debian.org\/debian jessie-updates main' /etc/apt/sources.list

RUN apt-get update -qq && apt-get -y install build-essential curl locales

# Генерация UTF-8 локалей
RUN locale-gen ru_RU.UTF-8
ENV LC_ALL=ru_RU.UTF-8
ENV LANG=ru_RU.UTF-8
RUN echo 'ru_RU.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen

ENV APP_PATH=/news/
RUN mkdir $APP_PATH
WORKDIR $APP_PATH

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"
#COPY Gemfile* $APP_PATH
#RUN mkdir -p $APP_PATH/vendor/bundle/
#RUN mkdir -p $APP_PATH/tmp/pids/
#COPY vendor/bundle/ $APP_PATH/vendor/bundle/

RUN bundle install

COPY . $APP_PATH

RUN bundle exec rake assets:precompile

#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
#
#RUN echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list
#
#RUN apt-get update && apt-get install -y mongodb-org
#
#RUN mkdir -p /data/db
#
#EXPOSE 27017
#
#ENTRYPOINT ["/usr/bin/mongod"]

