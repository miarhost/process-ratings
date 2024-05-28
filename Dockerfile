

FROM ruby:3.2.1-alpine
RUN apk --update add build-base git postgresql-dev postgresql-client tzdata imagemagick
WORKDIR /app
COPY Gemfile* ./

RUN gem install bundler && bundle install
ADD . /app

FROM mongo:latest
WORKDIR /
ENV MONGO_INITDB_ROOT_USERNAME admin-user
ENV MONGO_INITDB_ROOT_PASSWORD admin-password
ENV MONGO_INITDB_DATABASE admin

ADD ./docker/mongo/mongo-init.js /docker-entrypoint-initdb.d/

CMD ["mongod"]
EXPOSE 20217
