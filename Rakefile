# frozen_string_literal: true

# read more about what rake does
# https://github.com/ruby/rake

require 'rake/testtask'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'

require 'pry' unless ENV['APP_ENV'] == 'production'

require_relative 'app'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'This a sample rake task'
# $ rake cron_rake_task
task :cron_rake_task do
  puts 'Run!'
end

task default: :test
