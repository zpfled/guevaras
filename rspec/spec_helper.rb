require 'rack/test'

require File.expand_path '../../2chez.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() TwoChez end
end

RSpec.configure { |c| c.include RSpecMixin }



