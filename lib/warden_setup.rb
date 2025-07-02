# frozen_string_literal: true

class MyApp < Sinatra::Base
  use ::Warden::Manager do |config|
    # Tell Warden how to save our User info into a session.
    # Sessions can only take strings, not Ruby code, we'll store
    # the User's `id`
    config.serialize_into_session(&:id)
    # Now tell Warden how to take what we've stored in the session
    # and get a User from that information.
    config.serialize_from_session { |id| User.find(id) }

    config.scope_defaults :default,
                          # "strategies" is an array of named methods with which to
                          # attempt authentication. We have to define this later.
                          strategies: [:password],
                          # The action is a route to send the user to when
                          # warden.authenticate! returns a false answer. We'll show
                          # this route below.
                          action: 'auth/unauthenticated'
    # When a user tries to log in and cannot, this specifies the
    # app to send the user to.
    config.failure_app = self
  end

  ::Warden::Manager.before_failure do |env, _opts|
    # Because authentication failure can happen on any request but
    # we handle it only under "post '/auth/unauthenticated'", we need
    # to change request to POST
    env['REQUEST_METHOD'] = 'POST'
    # And we need to do the following to work with Rack::MethodOverride
    # using `String.new("")` creates an unfrozen object, allowing this project
    # to work with the frozen_string_literal
    env.each_key do |key|
      env[key]['_method'] = String.new('post') if key == 'rack.request.form_hash'
    end
  end
  ::Warden::Strategies.add(:password) do
    def valid?
      params['user'] && params['user']['username'] && params['user']['password']
    end

    def authenticate! # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      client_ip = env['REMOTE_ADDR'] || env['HTTP_X_FORWARDED_FOR'] || 'unknown'

      # Check if IP is rate limited
      if RateLimiter.too_many_attempts?(client_ip)
        remaining_time = RateLimiter.time_until_reset(client_ip)
        throw(:warden, message: "Too many failed attempts. Try again in #{remaining_time / 60} minutes.")
      end

      user = User.find_by(username: params['user']['username'])

      if user&.authenticate?(params['user']['password'])
        # Clear failed attempts on successful login
        RateLimiter.clear_attempts(client_ip)
        success!(user)
      else
        # Record failed attempt
        RateLimiter.record_attempt(client_ip)
        throw(:warden, message: 'Invalid username or password')
      end
    end
  end

  get '/auth/login' do
    erb :'users/login'
  end

  post '/auth/login' do
    env['warden'].authenticate!

    flash[:success] = 'Successfully logged in'

    if session[:return_to].nil?
      redirect '/'
    else
      redirect session[:return_to]
    end
  end

  get '/auth/logout' do
    env['warden'].raw_session.inspect
    env['warden'].logout
    flash[:success] = 'Successfully logged out'
    redirect '/'
  end

  post '/auth/unauthenticated' do
    session[:return_to] = env['warden.options'][:attempted_path] if session[:return_to].nil?
    # Set the error and use a fallback if the message is not defined
    flash[:error] = env['warden.options'][:message] || 'You must log in'
    redirect '/auth/login'
  end
end
