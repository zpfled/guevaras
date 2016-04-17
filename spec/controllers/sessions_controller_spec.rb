require 'spec_helper'
require_relative '../../helpers/sessions_helper'

describe SessionsController do
  include Rack::Test::Methods

  let!(:user) do
    user = User.new(name: 'ron swanson', admin: true, email: 'ron@swan.com')
    user.password = '1234'
    user.save
    user
  end

  describe 'POST /api/v1/sessions' do

    context 'with the correct password' do
      it 'logs in the user' do
        params = { email: 'ron@swan.com', password: '1234' }
        post '/api/v1/sessions', user: params
        expect(last_response.status).to eq 201
      end
    end

    context 'with an incorrect password' do
      it 'returns an error' do
        params = { email: 'ron@swan.com', password: '5678' }
        expect {
          post '/api/v1/sessions', user: params
        }.to raise_error 'Incorrect username or password'
      end
    end
  end
end