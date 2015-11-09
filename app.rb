require 'bundler'
require 'sinatra/activerecord'
require './controllers/menu_items_controller'
require './controllers/users_controller'
require './models/user'
require './models/menu_item'
Bundler.require(:default, :development)

class API < Grape::API
  mount MenuItemsController
  mount UsersController
end

class Web < Sinatra::Application
	register Sinatra::ActiveRecordExtension

	# TODO: clean this up
	enable :sessions
		set :session_secret, 'persenukedipsekjonukpunon',
		expire_after: 3600

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