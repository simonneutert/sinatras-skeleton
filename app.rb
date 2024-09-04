# frozen_string_literal: true

require 'bundler/setup'

require 'sassc'
require 'sass-embedded'

require 'bcrypt'
require 'ostruct'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/flash'
require 'sprockets'
require 'uglifier'
require 'coffee-script'
require 'execjs'
require 'sinatra/activerecord'
require 'rack/protection'
require 'warden'

require 'pry' unless ENV['APP_ENV'] == 'production'

# modular Sinatra app inherit from Sinatra::Base
class MyApp < Sinatra::Base
  # Boolean specifying whether the HTTP POST _method parameter
  # hack should be enabled. When true, the actual HTTP request
  # method is overridden by the value of the _method parameter
  # included in the POST body. The _method hack is used to
  # make POST requests look like other request methods (e.g., PUT, DELETE)
  # and is typically only needed in shitty environments
  # – like HTML form submission –
  # that do not support the full range of HTTP methods.
  use Rack::MethodOverride

  set :method_override, true

  set :sessions, true

  # session support for your app
  use Rack::Session::Pool

  # flash messages are not integrated, yet
  # but loaded just in case someone finds the time
  register Sinatra::Flash

  set :root, File.dirname(__FILE__)
  # files in static are served on "root"
  set :public_folder, "#{File.dirname(__FILE__)}/static"
  # set "/views/layout.erb" as the standard/global template wrapper (yield)
  set :erb, format: :html5, layout: :layout

  # always add protection last!
  use Rack::Protection
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
