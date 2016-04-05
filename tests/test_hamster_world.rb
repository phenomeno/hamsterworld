require "./bin/app.rb"
require "test/unit"
require "rack/test"
require "json"

class HamsterAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get '/'
    assert last_response.ok?
    assert last_response.body.include?("Stewart's Dilapitated Hamster World")
  end

  def test_post_hamster
    post('/api/v1/hamsters', {'name': 'adf', 'color': 'rgba(140,194,97,0.47)'}.to_json, {"CONTENT_TYPE" => "application/json"})
    assert_equal JSON.parse(last_response.body)["ok"], true
    get '/api/v1/hamsters'
    latest_hamster = JSON.parse(last_response.body)[-1]
    assert_equal latest_hamster["color"], 'rgba(140,194,97,0.47)'
    assert_equal latest_hamster["name"], 'adf'
  end

end
