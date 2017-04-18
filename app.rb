# require gems and libs
require 'sinatra'
require 'sinatra/base'
require 'sinatra/flash'
require 'sprockets'
require 'uglifier'
require 'sass'
require 'coffee-script'
require 'execjs'
require 'sinatra/activerecord'
require 'warden'
require 'bcrypt'

unless ENV['RACK_ENV'] == "production"
  require 'pry'
end

# modular Sinatra app inherit from Sinatra::Base
class MyApp < Sinatra::Base
  # session support for your app
  use Rack::Session::Pool
  # flash messages are not integrated, yet
  # but loaded just in case someone finds the time
  register Sinatra::Flash
  set :root, File.dirname(__FILE__)
  # files in static are served on "root"
  set :public_folder, File.dirname(__FILE__) + '/static'
  # set "/views/layout.haml" as the standard/global template wrapper (yield)
  set :haml, format: :html5, layout: :layout
end

# require libs
Dir['./lib/*.rb'].each { |file| require_relative file }
# require configurations
Dir['./config/*.rb'].each { |file| require_relative file }
# require models
Dir['./models/*.rb'].each { |file| require_relative file }
# require controllers
Dir['./controllers/*.rb'].each { |file| require_relative file }
# require routes
Dir['./routes/*.rb'].each { |file| require_relative file }
