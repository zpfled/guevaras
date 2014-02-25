require 'bundler'
Bundler.require(:default, :development)

# DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://#{Dir.pwd}/2chez.db")
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Manager
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
	use Rack::Session::Cookie, 	secret: 		'kilimanjaro',
								expire_after: 	3600 # session expires after 1 hour

# Routes

#untested
get '/' do
	@title = 'Welcome'
	@menu_items = MenuItem.all
	@menus = ['lunch', 'dinner', 'small plates', 'wine', 'cocktails']
	@categories = ['small plates', 'starters', 'salads', 'sandwiches', 'chicken', 'veal', 'seafood', 'beef', 'lamb', 'pork', 'whites', 'reds', 'cocktails']
	
	@admin = false

	erb :index
end

#tested
get '/signup' do
	@title = 'Signup'
	@action = 'sign up'
	@users = Manager.all
	erb :login
end

#tested
post '/signup' do
	user = Manager.new
	user.name = params[:name]
	user.email = params[:email]
	user.password = params[:password]
	user.save
	redirect '/login'
end

#tested
get '/login' do
	@title = 'Login'
	@action = 'log in'
	erb :login
end

#tested
post '/login' do
	session[:name] = params[:name]
	session[:password] = params[:password]
	user = Manager.first(name: session[:name])

	if user.nil?
		redirect '/'
	elsif user.authenticate?(session[:password])
		redirect '/admin'
	else
		redirect '/login'
	end
end

# untested
get '/admin' do
	@title = 'Dashboard'
	
	@user = session[:name]
	@admin = true ? @user : false

	@menu_items = MenuItem.all
	@menus = ['lunch', 'dinner', 'small plates', 'wine', 'cocktails']
	@categories = ['small plates', 'starters', 'salads', 'sandwiches', 'chicken', 'veal', 'seafood', 'beef', 'lamb', 'pork', 'whites', 'reds', 'cocktails']

 	if @user && Manager.first(name: session[:name]).logged_in?(@user)
 		erb :admin
 	else 
 		redirect '/login'
 	end
end

get '/menu' do
	@user = session[:name]
	@admin = true ? @user : false
	
	@menu_items = MenuItem.all
	@menus = ['lunch', 'dinner', 'small plates', 'wine', 'cocktails']
	@categories = ['small plates', 'starters', 'salads', 'sandwiches', 'chicken', 'veal', 'seafood', 'beef', 'lamb', 'pork', 'whites', 'reds', 'cocktails']

 	if @user && Manager.first(name: session[:name]).logged_in?(@user)
 		erb :menu, layout: false
 	else
 		redirect '/'
 	end
end

# untested
post '/menu' do
	item = MenuItem.new
	item.name = params[:name]
	item.description = params[:description]
	item.price = params[:price]
	item.menu = params[:menu].split('-').join(' ')
	item.category = params[:category]
	item.save

	redirect '/menu'
end

# untested
delete '/menu' do
	item = MenuItem.first(name: params[:name])
	item.destroy
	redirect '/admin'
end

# untested
get '/:id/raise' do
	item = MenuItem.get params[:id]
	@price = item.price = item.price + 1
	item.save
	@name = item.name

	if request.xhr?
		halt 200, {name: @name, price: @price}.to_json
	else
		redirect '/'
	end


end

# untested
post '/reduce' do
	item = MenuItem.first(name: params[:name])
	item.price = item.price - 1
	item.save

	redirect '/admin'
end

end