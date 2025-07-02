# frozen_string_literal: true

require 'test_helper'
require 'active_support/core_ext/numeric/time'
require_relative '../lib/session_timeout'

class SessionTimeoutTest < Test::Unit::TestCase
  def setup
    @app = ->(_env) { [200, {}, ['OK']] }
    @middleware = SessionTimeout.new(@app, 1.hour)
  end

  def test_session_timeout_middleware_adds_last_activity
    env = { 'rack.session' => {} }

    @middleware.call(env)

    # Should add last_activity timestamp
    assert env['rack.session']['last_activity']
    assert env['rack.session']['last_activity'].is_a?(Integer)
  end

  def test_session_timeout_middleware_updates_activity
    session = { 'last_activity' => 5.minutes.ago.to_i }
    env = { 'rack.session' => session }

    old_activity = session['last_activity']

    @middleware.call(env)

    # Should update last_activity to current time
    assert session['last_activity'] > old_activity
  end

  def test_session_timeout_middleware_clears_expired_session
    # Create session that expired 2 hours ago (beyond 1 hour timeout)
    session = {
      'last_activity' => 2.hours.ago.to_i,
      'user_id' => 123,
      'some_data' => 'important'
    }
    env = { 'rack.session' => session }

    @middleware.call(env)

    # Session should be cleared except for new last_activity
    assert_nil session['user_id']
    assert_nil session['some_data']
    assert session['last_activity'] # Should have new timestamp
  end

  def test_session_timeout_middleware_preserves_active_session # rubocop:disable Metrics/MethodLength
    # Create session that's still active (30 minutes ago)
    session = {
      'last_activity' => 30.minutes.ago.to_i,
      'user_id' => 123,
      'some_data' => 'important'
    }
    env = { 'rack.session' => session }

    original_user_id = session['user_id']
    original_data = session['some_data']

    @middleware.call(env)

    # Session data should be preserved
    assert_equal original_user_id, session['user_id']
    assert_equal original_data, session['some_data']
    assert session['last_activity'] # Should have updated timestamp
  end

  def test_session_timeout_middleware_handles_nil_session
    env = { 'rack.session' => nil }

    # Should not crash with nil session
    assert_nothing_raised do
      @middleware.call(env)
    end
  end

  def test_session_timeout_middleware_handles_missing_last_activity
    session = { 'user_id' => 123 }
    env = { 'rack.session' => session }

    @middleware.call(env)

    # Should add last_activity timestamp
    assert session['last_activity']
    assert session['last_activity'].is_a?(Integer)

    # Should preserve existing data
    assert_equal 123, session['user_id']
  end
end
