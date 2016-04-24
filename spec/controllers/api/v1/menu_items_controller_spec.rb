require 'spec_helper'

describe MenuItemsController do
  include Rack::Test::Methods

  describe 'CREATE' do
    context 'from an unapproved phone number' do
      it 'returns an error message' do
        params = { 'From' => nil, 'Body' => 'create' }
        # post '/api/v1/menu_items'
        get '/api/v1/menu_items/create.json', params

        res = "Uh oh! It looks like you're trying to update the menu from an unauthorized phone."
        json_data = JSON.parse(last_response.body)
        expect(json_data['text'].include? res).to be true
      end
    end

    context 'from an approved phone number' do
      it 'passes the user input to MenuItemService.create' do

      end
    end
  end

  describe 'READ' do
    before do
      dinner_menu = Menu.create(name: 'dinner')
      dinner_category = Category.create(name: 'beef', menu_id: dinner_menu.id)

      lunch_menu = Menu.create(name: 'lunch')
      lunch_category = Category.create(name: 'beef', menu_id: lunch_menu.id)

      lunch_item = MenuItem.new(price: 5, description: 'yum!', name: 'oxtail')
      lunch_item.category = lunch_category
      lunch_item.menu = lunch_menu
      lunch_item.save!

      dinner_item = MenuItem.new(price: 50, description: 'tasty meat!', name: 'steak')
      dinner_item.category = dinner_category
      dinner_item.menu = dinner_menu
      dinner_item.save!
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
end