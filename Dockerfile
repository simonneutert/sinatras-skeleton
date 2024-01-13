FROM ruby:3.3-slim

ENV RUBY_YJIT_ENABLE=1

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y \
        build-essential \
        curl \
        libpq-dev

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY . /app

CMD ["rackup", "-o", "0", "-p", "3000"]