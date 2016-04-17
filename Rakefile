require 'sinatra/activerecord/rake'
require_relative './app'

namespace :db do
  task :load_config do
    require './app'
  end
end

namespace :grape do
  desc 'Print compiled grape routes'
  task :routes do
    API.routes.each do |route|
      puts route.path
    end
  end
end