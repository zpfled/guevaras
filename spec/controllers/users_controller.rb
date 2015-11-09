require 'spec_helper'

describe UsersController do
  include Rack::Test::Methods

  # let!(:user) do
  #   user = User.new(name: 'ron swanson', admin: true, email: 'ron@swan.com')
  #   user.password = '1234'
  #   user.save
  # end

  context 'POST /api/v1/users' do
    it 'creates a new user' do
      params = {name: 'Carl Weathers', password: '123', email: 'carl@email.com'}
      post '/api/v1/users', user: params

      json_data = JSON.parse(last_response.body)

      expect(last_response.status).to eq 201
      expect(json_data['name']).to eq 'Carl Weathers'
      expect(User.last.password == '123').to be true
    end
  end

end