require 'bundler'
require 'sinatra/activerecord'
require './models/user'
require './models/menu_item'
# require './api/menu_items_controller'
Bundler.require(:default, :development)

class API < Grape::API
  version 'v1', using: :path
  format :json
  prefix :api

  resource :menu_items do
    desc 'Get all menu items'
    get do
      MenuItem.all
    end

    desc 'Get lunch menu'
    get :lunch do
      MenuItem.where(menu: 'lunch')
    end

    desc 'Get small plates menu'
    get :small_plates do
      MenuItem.where(menu: 'small plates')
    end

    desc 'Get wine list'
    get :wine do
      MenuItem.where(menu: 'wine')
    end

    desc 'Get dinner menu'
    get :dinner do
      MenuItem.where(menu: 'dinner')
    end
	end
end

class Web < Sinatra::Application
	register Sinatra::ActiveRecordExtension

	# TODO: clean this up
	enable :sessions
		set :session_secret, 'persenukedipsekjonukpunon',
		expire_after: 	3600 # session expires after 1 hour

	# TODO: rm this
	before do
		@menu_items = MenuItem.all

		@menus = []
		@menu_items.map { |item| @menus.push(item.menu) unless @menus.include?(item.menu) }
		@menus.sort!.rotate!

		@categories = []
		@menu_items.map { |item| @categories.push(item.category) unless @categories.include?(item.category) }
		@categories.sort!
	end

	# TODO: is this necessary?
	options '/*' do
	  response['Access-Control-Allow-Origin'] = "*"
	  headers['Access-Control-Allow-Methods'] = "GET, POST, PUT, DELETE, OPTIONS"
	  headers['Access-Control-Allow-Headers'] ="accept, authorization, origin"
	end

	# TODO: this is the only route that should remain...everything else will be JS
	get '/' do
		erb :index
	end

	get '/signup' do
		# Protect '/signup' from unauthorized users
		redirect '/login'
	end

	# Login Routes
	get '/login' do
		@message = "#{User.last.name}, #{User.last.password}"
		@action = 'log in'
		erb :login
	end

	post '/login' do
		session[:name] = params[:name]
		@password = session[:password] = params[:password]

		user = User.first(name: session[:name])

		if user.nil?
			redirect '/'
		elsif user.authenticate?(@password)
			redirect '/admin'
		else
			redirect '/login'
		end
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

	# Update Personal Info
	post '/:id/update/email' do
		admin = User.first
		user = User.first(id: params[:id])


		if params[:email] != ""
			user.email = params[:email]
			user.save

			halt 200, "email change success"
		end

		redirect '/admin'

	end

	post '/:id/update/password' do
		admin = User.first
		user = User.first(id: params[:id])

		if params[:old_password] != ""
			old_password = params[:old_password]
			new_password = params[:new_password]
			confirm_password = params[:confirm_password]

			if user.password == old_password.to_s  && new_password == confirm_password
				user.password = new_password
				user.save

				halt 200, "password change success"
			else
				halt 500
			end
		end

		redirect '/admin'
	end

	# Logout
	post '/logout' do
		session.destroy
		redirect '/'
	end
end