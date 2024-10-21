# Etapa 1: Construcción
FROM ruby:3.1.2 AS builder
WORKDIR /app

RUN apt-get update -qq && \
    apt-get install -y curl gnupg2 nodejs postgresql-client

COPY Gemfile Gemfile.lock ./

RUN bundle install --without development test

COPY . .

RUN bundle exec rake assets:precompile

FROM ruby:3.1.2
WORKDIR /app

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /app /app

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0", "-e", "production"]