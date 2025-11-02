# frozen_string_literal: true

require 'bundler/setup'

require 'sassc'
require 'sass-embedded'

require 'bcrypt'
require 'ostruct'
require 'securerandom'
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

require 'pry' unless ENV.fetch('APP_ENV', '').downcase == 'production'

# Load SessionTimeout middleware
require_relative 'lib/session_timeout'
require_relative 'lib/secure_random_session_secret'

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

  # Configure secure sessions
  use Rack::Session::Cookie,
      key: 'sinatras_skeleton_session',
      expire_after: 2.hours.to_i,
      secret: ENV.fetch('SESSION_SECRET', SecureRandomSessionSecret.generate).to_s,
      secure: ENV.fetch('APP_ENV', '').downcase == 'production',
      httponly: true,
      same_site: :strict

  # Add session timeout handling (1 hour of inactivity)
  use SessionTimeout, 1.hour

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
