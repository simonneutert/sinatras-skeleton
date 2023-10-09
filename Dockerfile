FROM ruby:3.2-slim

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY . /app

CMD ["rackup", "-o", "0", "-p", "3000"]