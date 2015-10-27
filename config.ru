require './app'
run Rack::Cascade.new([API, Web])