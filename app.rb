require 'bundler'
require 'sinatra/activerecord'
require './controllers/menu_items_controller'
require './controllers/users_controller'
require './models/user'
require './models/menu_item'
Bundler.require(:default, :development)

class API < Grape::API
  mount MenuItemsController
end

class Web < Sinatra::Application
	register Sinatra::ActiveRecordExtension

	# TODO: this is the only route that should remain...everything else will be JS
	get '/' do
		erb :index
	end

	# Single-Button Menu Updates
	get '/:id/raise' do
		item = MenuItem.get params[:id]
		@price = item.price = item.price + 1
		item.save

		if request.xhr?
			halt 200, "#{@price}"
		else
			redirect '/'
		end
	end

	get '/:id/reduce' do
		item = MenuItem.get params[:id]
		@price = item.price = item.price - 1
		item.save

		p request.xhr?
		if request.xhr?
			halt 200, "#{@price}"
		else
			redirect '/'
		end
	end
end