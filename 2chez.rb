require 'bundler'
Bundler.require(:default, :development)

# DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://#{Dir.pwd}/2chez.db")
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Manager
	include DataMapper::Resource
	include BCrypt

	property :id, 		   	Serial
	property :name, 		Text,		required: true,		unique: true
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
	property :menu,			String, 	required: true
	property :name,			String, 	required: true
	property :description,	Text, 		required: true
	property :price,		Integer, 	required: true
	property :added_on,		Date
	property :updated_on,	Date
end


DataMapper.finalize.auto_upgrade!
# DataMapper.finalize.auto_migrate!

class TwoChez < Sinatra::Application
	use Rack::Session::Cookie, 	secret: 		'kilimanjaro',
								expire_after: 	3600 # session expires after 1 hour

# Routes

get '/' do
	@title = 'Welcome'
	@css = 'main'
	erb :index
end

get '/signup' do
	@title = 'Signup'
	@action = 'sign up'
	@css = 'main'
	@users = Manager.all
	erb :login
end

post '/signup' do
	user = Manager.new
	user.name = params[:name]
	user.email = params[:email]
	user.password = params[:password]
	user.save
	redirect '/signup'
end

get '/login' do
	@title = 'Login'
	@action = 'log in'
	@css = 'main'
	erb :login
end

post '/login' do
	session[:name] = params[:name]
	session[:password] = params[:password]
	
	user = Manager.first(email: session[:email])

	if user.nil?
		redirect '/signup'
	elsif user.authenticate?(session[:password])
		redirect '/admin'
	else
		redirect '/'
	end
end


get '/admin' do
	item = MenuItem.new
	item.menu = "dinner"
	item.name = "chicken pesto sandwich"
	item.description = "yummy sandwich with chicken and pesto and bread and a pickle and cheese and mushrooms."
	item.price = "9"
	item.save
	@title = 'Dashboard'
	@css = 'admin'
	@menu_items = MenuItem.all
	erb :admin, layout: false
end

end