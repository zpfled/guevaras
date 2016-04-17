require 'bundler'
require 'sinatra/activerecord'
require './controllers/menu_items_controller'
require './models/menu_item'
Bundler.require(:default, :development)

class API < Grape::API
  mount MenuItemsController
end

class Web < Sinatra::Application
	register Sinatra::ActiveRecordExtension

	# TODO: this is the only route that should remain...everything else will be JS
	get '/' do
		erb :index, layout: false
	end

	get '/twilio' do
		'Hello World! Currently running version ' + Twilio::VERSION + \
        ' of the twilio-ruby library.'
  end

  get '/sms-quickstart' do
	  content_type 'text/xml'

	  res = Twilio::TwiML::Response.new do |r|
	    r.Sms "Hey Monkey. Thanks for the message 4!"
	  end
	  p res.to_xml
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