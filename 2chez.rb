require 'bundler'
Bundler.require(:default, :development)

# DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/2chez')
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class User
	include DataMapper::Resource
	include BCrypt

	property :id, 		   	Serial
	property :name, 		Text,		required: true,		unique: true,	key: true
	property :email,		Text,		required: true,		unique: true,	format: :email_address
	property :password, 	BCryptHash, required: true,		length: 8..255
	property :admin,		Boolean,	default: false,		writer: :protected

	def authenticate?(attempted_password)
		self.password == attempted_password ? true : false
	end

	def logged_in?(user)
		self.name == user ? true : false
	end

end

class MenuItem
	include DataMapper::Resource

	property :id,			Serial
	property :menu,			String, 	required: true # e.g. Lunch, Dinner, Wine
	property :category,		String,		required: true # e.g. Starters, Chicken, Cabernet Sauvignon, Interesting Whites
	property :name,			String, 	required: true # e.g. Calimari, Snoqualmie
	property :description,	Text, 		required: true
	property :price,		Integer, 	required: true
end

DataMapper.finalize.auto_upgrade!
# DataMapper.finalize.auto_migrate!

class TwoChez < Sinatra::Application
	enable :sessions
		set :session_secret, 'persenukedipsekjonukpunon',
		expire_after: 	3600 # session expires after 1 hour

# Routes

before do
	@user = session[:name]
	@users = User.all
	@menu_items = MenuItem.all

	@menus = []
	@menu_items.map { |item| @menus.push(item.menu) unless @menus.include?(item.menu) }
	@menus.sort.rotate!

	@categories = []
	@menu_items.map { |item| @categories.push(item.category) unless @categories.include?(item.category) }
	@categories.sort!
end

after do
	p "Params: #{params}"
end

options '/*' do
    headers['Access-Control-Allow-Origin'] = "*"
    headers['Access-Control-Allow-Methods'] = "GET, POST, PUT, DELETE, OPTIONS"
    headers['Access-Control-Allow-Headers'] ="accept, authorization, origin"
end

get '/' do
	@title = 'Welcome'
	@admin = false

	erb :index
end

get '/signup' do
	redirect '/login'
end

post '/signup' do
	@user_exists = false

 	@users.each { |user| @user_exists = true if params[:name] == user.name }

 	if @user_exists
 		halt 404
 	else
		user = User.new
		user.name = params[:name]
		user.email = params[:email]
		user.password = 'password'
		user.save

		redirect '/menu'
	end
end

post '/user/delete' do
	user = User.first(name: params[:name])
	if user.name == session[:name] || user.admin
		halt 500
		redirect '/menu' 
	else
		user.destroy
		redirect '/menu'
	end
end

get '/login' do
	@message = "#{User.last.name}, #{User.last.password}"
	@title = 'Login'
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
		redirect "/#{user.password}"
	end
end

post '/logout' do
	session.destroy
	redirect '/'
end

get '/admin' do
	if session[:name]
		@id = User.first(name: session[:name]).id
	end
	@title = 'Dashboard'
	@admin = true ? @user : false

 	if @user && User.first(name: session[:name]).logged_in?(@user)
 		erb :admin
 	else 
 		redirect '/login'
 		# erb :admin
 	end
end

get '/menu' do
	@admin = true ? @user : false
	
 	if @user && User.first(name: session[:name]).logged_in?(@user)
 		erb :menu, layout: false
 	else
 		redirect '/'
 	end
end

post '/menu' do
	item = MenuItem.new
	item.name = params[:name]
	item.description = params[:description]
	item.price = params[:price]
	item.menu = params[:menu].split('-').join(' ')
	cat = "#{params[:menu]}_category".to_sym
	item.category = params[cat]
	item.save

	redirect '/menu'
end

post '/edit' do
	selector = "#{params[:menu]}_edit".to_sym
	item = MenuItem.first(id: params[selector])
	if params[:name] != ""
		item.name = params[:name]
	end
	if params[:description] != ""
		item.description = params[:description]
	end
	if params[:price] != ""
		item.price = params[:price]
	end
	item.save
			
	redirect '/menu'
end

post '/:id/update' do
	user = User.first(id: params[:id])
	if params[:email] != ""
		# send email to user.email
		user.email = params[:email]
		halt 200, "email change success"
	end
	if params[:old_password] != ""
		if params[:old_password] == user.password && params[:new_password] == params[:confirm_password] && request.xhr?
			user.password = params[:new_password]
			# send email to user.email
			halt 200, "password change success"
		else
			halt 500, "password change failed"
			# send email to user.email
		end
	end
	user.save

	redirect '/admin'
end


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

	if request.xhr?
		halt 200, "#{@price}"
	else
		redirect '/'
	end
end

get '/:id/delete' do
	item = MenuItem.get params[:id]
	item.destroy
	@name = item.name

	if request.xhr?
		halt 200, "#{@name}"
	else
		redirect '/'
	end
end

end