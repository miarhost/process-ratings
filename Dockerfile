

FROM ruby:3.2.1-alpine
RUN apk --update add build-base git postgresql-dev postgresql-client tzdata imagemagick
WORKDIR /app
COPY Gemfile* ./

RUN gem install bundler && bundle install
ADD . /app

CMD ["bundle","exec","puma","-C","config/puma.rb"]
EXPOSE 3002
