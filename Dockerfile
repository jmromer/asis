FROM ruby:2.7.7-alpine AS builder

RUN apk update && \
    apk upgrade && \
    apk add --no-cache --update bash git build-base gcc wget ruby-full

RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN gem install bundler
RUN bundle check || bundle install --jobs 4


FROM ruby:2.7.7-alpine AS runner

WORKDIR /app
RUN apk add tzdata
COPY --from=builder /usr/local/bundle /usr/local/bundle
ADD . /app
