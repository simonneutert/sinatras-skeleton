# frozen_string_literal: true

require 'test_helper'

OUTER_APP = Rack::Builder.parse_file('config.ru')

class HomepageTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    OUTER_APP
  end

  def test_root
    get '/'
    assert last_response.ok?
  end

  def test_cave_name_endpoint
    get '/cave/Sinatra'
    assert last_response.ok?
    body = last_response.body
    assert body.include?('<h1>The Cave</h1>')

    get '/cave/Simon'
    assert last_response.ok?
    body = last_response.body
    refute body.include?('<h1>The Cave</h1>')
  end

  def test_time_endpoint
    get '/time'
    assert last_response.ok?
    body = last_response.body
    assert body.include?('Losing your mind already?')
  end

  def database_endpoint
    get '/database'
    assert last_response.ok?
    body = last_response.body
    assert body.include?('easy peasy database handling')
  end

  def test_get_user_id_not_logged_in_endpoint
    get '/users/1'
    refute last_response.ok?
  end

  def test_new_skeleton_form_endpoint
    get '/new_skeleton_form'
    assert last_response.redirect?
    follow_redirect!
    assert last_response.body.include?('You must log in')
  end

  def test_post_user_signin_endpoint
    post '/auth/login', user: { username: 'User', password: 'Secret' }
    assert last_response.redirect?
    follow_redirect!
    assert last_response.ok?

    get '/new_skeleton_form'
    assert last_response.body.include?('New Skeleton')
  end

  def test_user_cannot_access_other_users_profile
    post '/auth/login', user: { username: 'User', password: 'Secret' }
    assert last_response.redirect?
    follow_redirect!
    assert last_response.ok?

    # Try to access non-existent user
    get '/users/2'
    assert last_response.redirect?
    follow_redirect!
    assert last_response.body.include?('Stop trying to hack')
  end

  def test_user_cannot_access_not_existing_users_profile
    post '/auth/login', user: { username: 'User', password: 'Secret' }
    assert last_response.redirect?
    follow_redirect!
    assert last_response.ok?

    # Try to access non-existent user
    get '/users/999'
    assert last_response.redirect?
    follow_redirect!
    assert last_response.body.include?('Access denied')
  end

  def test_user_cannot_update_other_users_profile
    post '/auth/login', user: { username: 'User', password: 'Secret' }
    assert last_response.redirect?
    follow_redirect!
    assert last_response.ok?

    # Try to update User2's profile (should be denied)
    post '/users/2', user: { username: 'hacked', password: 'newpass', rpassword: 'newpass' }
    assert last_response.redirect?
    follow_redirect!
    assert last_response.body.include?('Stop trying to hack')
  end

  def test_rate_limiting_blocks_too_many_failed_attempts
    # Clear any existing rate limit data
    RateLimiter.clear_attempts('127.0.0.1')
    
    # Make 5 failed login attempts
    5.times do
      post '/auth/login', user: { username: 'User', password: 'WrongPassword' }
      assert last_response.redirect?
      follow_redirect!
      assert last_response.body.include?('Invalid username or password')
    end
    
    # 6th attempt should be rate limited
    post '/auth/login', user: { username: 'User', password: 'WrongPassword' }
    assert last_response.redirect?
    follow_redirect!
    assert last_response.body.include?('Too many failed attempts')
  end

  def test_successful_login_clears_rate_limit
    # Clear any existing rate limit data
    RateLimiter.clear_attempts('127.0.0.1')
    
    # Make 4 failed attempts (just under the limit)
    4.times do
      post '/auth/login', user: { username: 'User', password: 'WrongPassword' }
      assert last_response.redirect?
    end
    
    # Successful login should clear the attempts
    post '/auth/login', user: { username: 'User', password: 'Secret' }
    assert last_response.redirect?
    follow_redirect!
    assert last_response.ok?
    
    # Logout to clear session
    get '/auth/logout'
    
    # Should be able to make failed attempts again (proving reset worked)
    post '/auth/login', user: { username: 'User', password: 'WrongPassword' }
    assert last_response.redirect?
    follow_redirect!
    assert last_response.body.include?('Invalid username or password')
    refute last_response.body.include?('Too many failed attempts')
  end
end
