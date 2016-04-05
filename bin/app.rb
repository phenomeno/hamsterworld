require 'sinatra'
require 'json'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"
set :show_exceptions, :after_handler

# Fake data
hamsters = [
  {'id' => 1, 'name' => 'Stewart', 'color' => 'rgba(255,0,0,0.75)', 'hunger' => 3, 'stress' => 4, 'health' => 2, 'survival' => 0.3},
  {'id' => 2, 'name' => 'Grace', 'color' => 'rgba(0,255,0,0.75)', 'hunger' => 1, 'stress' => 3, 'health' => 4, 'survival' => 0.7}
]

index = hamsters.index { |hamster| hamster['id'] == 1 }
puts index

error 500 do
  'Server error.'
end

get '/' do
  erb :index
end

# APIs

# Get all hamsters
get '/api/v1/hamsters' do
  JSON.generate(hamsters)
end

# Get one hamster
get '/api/v1/hamsters/:id' do
  id = params['id'].to_i
  index = hamsters.index { |hamster| hamster['id'] == id }
  JSON.generate(hamsters[index])
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
  hamsters.push({'id' => hamsters[-1]["id"]+1, 'name' => name, 'color' => color, 'hunger' => hunger, 'stress' => stress, 'health' => health, 'survival' => survival })
  JSON.generate({ 'ok': true })
end

# Put - replace whole hamster
put '/api/v1/hamsters/:id' do
  id = params['id'].to_i
  new_hamster = JSON.parse(request.body.read)["hamster"]
  index = hamsters.index { |h| h['id'] == id }
  if index
    hamsters[index] = new_hamster
    JSON.generate(hamsters)
  else
    raise 500
  end
end

# Patch - replace a few attributes in a hamster
patch '/api/v1/hamsters/:id' do
  id = params['id'].to_i
  update_hamster = JSON.parse(request.body.read)["hamster"]
  puts update_hamster
  index = hamsters.index { |h| h['id'] == id }
  if index
    hamster = hamsters[index]
    hamster['name'] = update_hamster['name'] if update_hamster.key?('name')
    hamster['color'] = update_hamster['color'] if update_hamster.key?('color')
    hamster['hunger'] = update_hamster['hunger'] if update_hamster.key?('hunger')
    hamster['stress'] = update_hamster['stress'] if update_hamster.key?('stress')
    hamster['health'] = update_hamster['health'] if update_hamster.key?('health')
    hamster['survival'] = rand(1..101)/100.0
    JSON.generate({ 'ok': true })
  else
    raise 500
  end
end

# Delete a hamster :(
delete '/api/v1/hamsters/:id' do
  id = params['id'].to_i
  index = hamsters.index { |h| h['id'] == id }
  hamsters.delete_at(index)
  JSON.generate({ 'ok': true })
end

# Delete all the hamsters
delete '/api/v1/hamsters' do
  hamsters = []
  puts hamsters.length
  JSON.generate({ 'ok': true })
end
