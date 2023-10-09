# frozen_string_literal: true

require 'test/unit'
require 'rack/test'
require 'json'

class HomepageTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    ->(_env) { [200, { 'content-type' => 'text/plain' }, ['All responses are OK']] }
  end

  def test_response_is_ok
    # Optionally set headers used for all requests in this spec:
    # header 'accept-charset', 'utf-8'

    # First argument is treated as the path
    get '/'

    assert last_response.ok?
    assert_equal 'All responses are OK', last_response.body
  end
end
