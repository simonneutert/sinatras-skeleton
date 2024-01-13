# frozen_string_literal: true

class MyApp < Sinatra::Base
  # initialize new sprockets environment
  set :environment, Sprockets::Environment.new
  # append assets paths
  environment.append_path 'assets/stylesheets'
  environment.append_path 'assets/javascripts'
  # compress assets
  environment.js_compressor = :uglify

  # get assets
  get '/assets/*' do
    env['PATH_INFO'].sub!('/assets', '')
    settings.environment.call(env)
  end
end
