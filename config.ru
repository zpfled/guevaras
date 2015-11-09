require './app'
ENV['RACK_ENV'] ||= 'development'
run Rack::Cascade.new([API, Web])