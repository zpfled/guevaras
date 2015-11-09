require 'spec_helper'

describe MenuItemsController do
  include Rack::Test::Methods

  let!(:lunch_item) do
    MenuItem.create(category: 'beef',
                    menu: 'lunch',
                    price: 5,
                    description: 'yum!',
                    name: 'oxtail')
  end

  let!(:dinner_item) do
    MenuItem.create(category: 'pork',
      menu: 'dinner',
      price: 14,
      description: 'reaaaal good',
      name: 'cracklins')
  end

  context 'GET /api/v1/menu_items' do
    it 'returns all the menu items' do
      get '/api/v1/menu_items'

      json_data = JSON.parse(last_response.body)

      expect(last_response.status).to eq 200
      expect(json_data.length).to eq 2
    end
  end

  context 'GET /api/v1/menu_items/lunch' do
    it 'only returns lunch menu items' do
      get '/api/v1/menu_items/lunch'

      json_data = JSON.parse(last_response.body)

      expect(json_data.length).to eq 1
      expect(json_data[0]['name']).to eq 'oxtail'
    end
  end
end