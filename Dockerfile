FROM ruby:2.7.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs 

RUN mkdir /Chat_System
WORKDIR /Chat_System

ADD Gemfile /Chat_System/Gemfile
ADD Gemfile.lock /Chat_System/Gemfile.lock

RUN bundle install

ADD . /Chat_System