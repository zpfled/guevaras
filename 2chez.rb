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
	# property :added_on,		Date
	# property :updated_on,	Date
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
	@css = 'main'
	@menu_items = MenuItem.all
	erb :index
end

#tested
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
	redirect '/login'
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
	user = Manager.first(name: session[:name])

	if user.nil?
		redirect '/'
	elsif user.authenticate?(session[:password])
		redirect '/admin'
	end
end

get '/admin' do
	@title = 'Dashboard'
	@css = 'admin'
	@menu_items = MenuItem.all
	@user = session[:name]

	if @user.nil?
		redirect '/login'
	else 
		erb :admin, layout: false
	end

end

end