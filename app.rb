require 'bundler'
require 'sinatra/activerecord'
Bundler.require(:default, :development)

# Models
require './models/category'
require './models/menu'
require './models/menu_item'
require './models/menu_item_draft'
# Controllers
require './controllers/api/v1/menu_items_controller'
# Helpers
require './helpers/twilio_helper'

class API < Grape::API
  mount MenuItemsController
end

class Web < Sinatra::Application
	register Sinatra::ActiveRecordExtension

	get '/' do
		erb :index, layout: false
	end
end