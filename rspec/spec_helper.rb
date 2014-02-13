# require 'rack/test'
# require 'rspec'

# require File.expand_path '../../2chez.rb', __FILE__

# module RSpecMixin
#   include Rack::Test::Methods
#   def app() TwoChez end
# end

# RSpec.configure { |c| c.include RSpecMixin }

require 'rubygems'
require 'spork'

ENV['RACK_ENV'] = 'test'                    # force the environment to 'test'

Spork.prefork do
  require File.join(File.dirname(__FILE__), '..', '2chez.rb')

  require 'rubygems'
  require 'sinatra'
  require 'rspec'
  require 'rack/test'
  require 'capybara'
  require 'capybara/dsl'

  Capybara.app = TwoChez       # in order to make Capybara work

  # set test environments
  set :environment, :test
  set :run, false
  set :raise_errors, true
  set :logging, false

  RSpec.configure do |conf|
    conf.include Rack::Test::Methods
    conf.include Capybara::DSL
  end

  def app
    @app ||= TwoChez
  end
end

Spork.each_run do
end