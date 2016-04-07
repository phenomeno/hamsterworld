require "./bin/app.rb"
require "test/unit"
require "rack/test"
require "json"

class HamsterAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  @sample_hamster = {
    'name': 'Test Hamster',
    'color': 'rgba(140,194,97,0.47)',
    'hunger': 3,
    'stress': 3,
    'health': 2
  }

  def test_index
    get '/'
    assert last_response.ok?
    assert last_response.body.include?("Stewart's Dilapitated Hamster World")
  end

  def test_get_all_hamsters
    get '/api/v1/hamsters'
    hamster_count = JSON.parse(last_response.body).length
    hamster = {
      'name': 'Test Hamster',
      'color': 'rgba(140,194,97,0.47)',
      'hunger': 3,
      'stress': 3,
      'health': 2
    }.to_json
    post('/api/v1/hamsters', hamster, {"CONTENT_TYPE" => "application/json"})

    puts JSON.parse(last_response.body)
    get '/api/v1/hamsters'
    latest_hamster_count = JSON.parse(last_response.body).length
    assert_equal (hamster_count + 1), latest_hamster_count
  end

  def test_post_hamster
    post('/api/v1/hamsters', @sample_hamster.to_json, {"CONTENT_TYPE" => "application/json"})
    posted_hamster = JSON.parse(last_response.body)
    get '/api/v1/hamsters'
    hamster = JSON.parse(last_response.body)[-1]
    assert_equal hamster["name"], posted_hamster["name"]
    assert_equal hamster["color"], posted_hamster["color"]
    assert_equal hamster["hunger"], posted_hamster["hunger"]
    assert_equal hamster["stress"], posted_hamster["stress"]
    assert_equal hamster["health"], posted_hamster["health"]
    assert_equal hamster["survival"], posted_hamster["survival"]
  end


end
