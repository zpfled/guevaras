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
    	if self.password == attempted_password
      		true
    	else
      		false
    	end
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

#tested
get '/' do
	@title = 'Welcome'
	@menu_items = MenuItem.all
	erb :index
end

#tested
get '/signup' do
	@title = 'Signup'
	@action = 'sign up'
	@users = Manager.all
	erb :login
end

post '/signup' do
	user = Manager.new
	user.name = params[:name]
	user.email = params[:email]
	user.password = params[:password]
	user.save
	redirect '/login'
end

get '/login' do
	@title = 'Login'
	@action = 'log in'
	erb :login
end

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

get '/admin' do
	@title = 'Dashboard'
	@user = session[:name]
	@admin = true ? @user : false
	@menu_items = MenuItem.all
	@menu = ['lunch', 'dinner', 'small plates', 'wine', 'cocktails']
	@menu_items.each { |item| @menu.push(item.menu).sort unless @menu.include?(item.menu) }

 	if @user
		@current_user = Manager.first(name: session[:name])
		if @user != @current_user.name
			redirect '/'
		else
			erb :admin
		end
	else
		redirect '/login'
	end
end

post '/menu' do
	item = MenuItem.new
	item.name = params[:name]
	item.description = params[:description]
	item.price = params[:price]
	item.menu = params[:menu].split('-').join(' ')
	item.category = params[:category]
	item.save

	redirect '/admin'
end

delete '/menu' do
	item = MenuItem.first(name: params[:name])
	item.destroy
	redirect '/admin'
end

post '/raise' do
	item = MenuItem.first(name: params[:name])
	item.price = item.price + 1
	item.save

	redirect '/admin'
end

post '/reduce' do
	item = MenuItem.first(name: params[:name])
	item.price = item.price - 1
	item.save

	redirect '/admin'
end


end