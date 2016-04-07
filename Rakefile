require './bin/app'
require 'sinatra/activerecord/rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
    t.libs << "tests"
    t.test_files = FileList['tests/test*.rb']
    t.verbose = true
end
