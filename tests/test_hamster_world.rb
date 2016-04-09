require "./bin/app.rb"
require "test/unit"
require "rack/test"
require "json"

# FIXME Find way to run rake:db seed first so there is an expectation of certain hamsters populated

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

  def test_get_all_hamsters
    get '/api/v1/hamsters'
    hamster_count = JSON.parse(last_response.body).length
    hamster = {'hamster': {
      'name': 'Test Hamster',
      'color': 'rgba(140,194,97,0.47)',
      'hunger': 3,
      'stress': 3,
      'health': 2
    }}.to_json
    post('/api/v1/hamsters', hamster, {"CONTENT_TYPE" => "application/json"})
    get '/api/v1/hamsters'
    latest_hamster_count = JSON.parse(last_response.body).length
    assert_equal (hamster_count + 1), latest_hamster_count
  end

  def test_post_hamster
    hamster = {'hamster'=> {
      'name'=> 'Test Hamster',
      'color'=> 'rgba(140,194,97,0.47)',
      'hunger'=> 3,
      'stress'=> 3,
      'health'=> 2
    }}
    post('/api/v1/hamsters', hamster.to_json, {"CONTENT_TYPE" => "application/json"})
    hamster_id = JSON.parse(last_response.body)["ok"]
    get '/api/v1/hamsters'
    posted_hamster = JSON.parse(last_response.body)[-1]
    assert_equal hamster["hamster"]["name"], posted_hamster["name"]
    assert_equal hamster["hamster"]["color"], posted_hamster["color"]
    assert_equal hamster["hamster"]["hunger"], posted_hamster["hunger"]
    assert_equal hamster["hamster"]["stress"], posted_hamster["stress"]
    assert_equal hamster["hamster"]["health"], posted_hamster["health"]
    assert_equal hamster_id, posted_hamster["id"]
  end

  def test_put_hamster
    hamster = {'hamster'=> {
      'name'=> 'Put Hamster',
      'color'=> 'rgba(0,194,97,0.47)',
      'hunger'=> 1,
      'stress'=> 1,
      'health'=> 1
    }}
    post('/api/v1/hamsters', hamster.to_json, {"CONTENT_TYPE" => "application/json"})
    hamster_id = JSON.parse(last_response.body)["ok"]
    post_hamster = {'hamster'=> {
      'name'=> 'Put Hamstie',
      'color'=> 'rgba(32,32,1,0.51)',
      'hunger'=> 2,
      'stress'=> 2,
      'health'=> 2
    }}
    put('/api/v1/hamsters/' + hamster_id.to_s, post_hamster.to_json, {"CONTENT_TYPE" => "application/json"})
    get '/api/v1/hamsters/'+hamster_id.to_s
    updated_hamster = JSON.parse(last_response.body)

    assert_equal post_hamster["hamster"]["name"], updated_hamster["name"]
    assert_equal post_hamster["hamster"]["color"], updated_hamster["color"]
    assert_equal post_hamster["hamster"]["hunger"], updated_hamster["hunger"]
    assert_equal post_hamster["hamster"]["stress"], updated_hamster["stress"]
    assert_equal post_hamster["hamster"]["health"], updated_hamster["health"]
  end

  def delete_a_hamster
    hamster = {'hamster'=> {
      'name'=> 'Put Hamster',
      'color'=> 'rgba(0,194,97,0.47)',
      'hunger'=> 1,
      'stress'=> 1,
      'health'=> 1
    }}
    post('/api/v1/hamsters', hamster.to_json, {"CONTENT_TYPE" => "application/json"})
    hamster_id = JSON.parse(last_response.body)["ok"]
    delete '/api/v1/hamsters'+hamster_id.to_s
    assert_equal JSON.parse(last_response.body)["ok"], true
  end
end
