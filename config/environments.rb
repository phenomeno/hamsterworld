configure :development, :test do
  set :database, {adapter: 'sqlite3', database: 'development.db'}
  set :port, 8080
  set :bind, '127.0.0.1'
end

configure :production do
  set :port, 80
  set :bind, '0.0.0.0'
end
