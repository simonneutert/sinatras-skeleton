default:
  @just --list

init:
  bundle exec rake db:setup

test:
  @bundle exec rubocop && bundle exec rake test