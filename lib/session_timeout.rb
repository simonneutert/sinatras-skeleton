# frozen_string_literal: true

# Middleware for handling session timeouts based on inactivity
# Automatically clears sessions that haven't been active for the specified timeout period
class SessionTimeout
  def initialize(app, timeout = 1.hour)
    @app = app
    @timeout = timeout
  end

  def call(env) # rubocop:disable Metrics/MethodLength
    session = env['rack.session']

    if session
      # Check if session has timed out
      if session['last_activity'] && session_expired?(session['last_activity'])
        # Clear all session data on timeout
        session.clear

        # Set flash message if flash is available
        if session.respond_to?(:flash) || env['rack.session'].respond_to?(:[]=)
          session['flash'] ||= {}
          session['flash']['info'] = 'Your session has expired. Please log in again.'
        end
      end

      # Update last activity timestamp for valid sessions
      session['last_activity'] = Time.now.to_i
    end

    @app.call(env)
  end

  private

  def session_expired?(last_activity_timestamp)
    return true unless last_activity_timestamp

    last_activity = Time.at(last_activity_timestamp)
    Time.now - last_activity > @timeout
  end
end
