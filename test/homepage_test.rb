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
end
