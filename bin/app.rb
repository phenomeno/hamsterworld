require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require './config/environments'
require './models'


# set :environment, ARGV[0]
set :environment, :development
set :static, true
set :public_folder, "static"
set :views, "views"
set :show_exceptions, :after_handler

register Sinatra::ActiveRecordExtension

error 500 do
  JSON.generate({'ok' => false })
end

#  Serve index.erb and let Angular handle using client-side routing
get '/' do
  erb :index
end

# APIs
# Get all hamsters
get '/api/v1/hamsters' do
  hamsters = Hamster.all.to_json
end

# Get one hamster
get '/api/v1/hamsters/:id' do
  id = params['id'].to_i
  hamster = Hamster.find_by(id: id).to_json
end

# Add a new hamster
post '/api/v1/hamsters' do
  data = JSON.parse(request.body.read)["hamster"]
  name = data["name"] || "Noname"
  color = data["color"] || "Black"
  hunger = data["hunger"] || 0
  stress = data["stress"] || 1
  health = data["health"] || 3
  survival = rand(1..101)/100.0
  Hamster.create(name: name, color: color, hunger: hunger, stress: stress, health: health, survival: survival)
  JSON.generate({ 'ok' => true })
end

# Put - replace whole hamster
put '/api/v1/hamsters/:id' do
  id = params['id'].to_i
  data = JSON.parse(request.body.read)["hamster"]
  name = data["name"]
  color = data["color"]
  hunger = data["hunger"]
  stress = data["stress"]
  health = data["health"]
  survival = rand(1..101)/100.0

  existing_hamster = Hamster.find_by(id: id)

  if existing_hamster
    existing_hamster.update(name: name, color: color, hunger: hunger, stress: stress, health: health, survival: survival)
    existing_hamster.to_json
  else
    raise 500
  end
end

# Patch - replace a few attributes in a hamster
patch '/api/v1/hamsters/:id' do
  id = params['id'].to_i
  data = JSON.parse(request.body.read)["hamster"]

  hamster = Hamster.find_by(id: id)

  if hamster
    hamster.name = data['name'] if data.key?('name')
    hamster.color = data['color'] if data.key?('color')
    hamster.hunger = data['hunger'] if data.key?('hunger')
    hamster.stress = data['stress'] if data.key?('stress')
    hamster.health = data['health'] if data.key?('health')
    hamster.survival = rand(1..101)/100.0
    hamster.save
    hamster.to_json
  else
    raise 500
  end
end

# Delete a hamster :(
delete '/api/v1/hamsters/:id' do
  id = params['id'].to_i
  hamster = Hamster.find_by(id: id)
  hamster.destroy
  JSON.generate({ 'ok' => true })
end

# Delete all the hamsters
delete '/api/v1/hamsters' do
  Hamster.destroy_all()
  JSON.generate({ 'ok' => true })
end
