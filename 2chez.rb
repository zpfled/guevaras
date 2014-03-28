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
	property :admin,		Boolean,	default: false#,		writer: :protected

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

configure :production do
	set :email_options, {
		via: 			:smtp,
		via_options: 	{
			address: 				'smtp.sendgrid.net',
			port: 	 				'587',
			domain: 				'heroku.com',
			user_name: 				ENV['SENDGRID_USERNAME'],
			password: 				ENV['SENDGRID_PASSWORD'],
			authentication: 		:plain,
			enable_starttls_auto: 	true
		}
	}

Pony.options = settings.email_options

end


class TwoChez < Sinatra::Application
	include BCrypt
	enable :sessions
		set :session_secret, 'persenukedipsekjonukpunon',
		expire_after: 	3600 # session expires after 1 hour

# Routes

# Before/After Blocks ----------------------------------------------------------

before do
	# Create initial user
	if User.all.length == 0
		zach = 	User.create 	name: 		'todd',
								email: 		'toddhohulin@mchsi.com',
								password: 	'password',
								admin: 		true
		zach.save
		todd = 	User.create 	name: 		'zach',
								email: 		'zpfled@gmail.com',
								password: 	'password',
								admin: 		true
		todd.save
	end


	@user = session[:name]
	@users = User.all
	@menu_items = MenuItem.all

	@menus = []
	@menu_items.map { |item| @menus.push(item.menu) unless @menus.include?(item.menu) }
	@menus.sort!.rotate!

	@categories = []
	@menu_items.map { |item| @categories.push(item.category) unless @categories.include?(item.category) }
	@categories.sort!

	# Set admin
	@users.each { |user| user.admin = true ? user.name == 'zach' || user.name == 'dave' || user.name = 'todd' : false; user.save }

end

after do
	p "Params: #{params}"
	p User.first.admin
end

options '/*' do
    headers['Access-Control-Allow-Origin'] = "*"
    headers['Access-Control-Allow-Methods'] = "GET, POST, PUT, DELETE, OPTIONS"
    headers['Access-Control-Allow-Headers'] ="accept, authorization, origin"
end

# Public Routes ---------------------------------------------------------------

get '/' do
	@title = 'Welcome'
	@admin = false
	@site_email = User.first.email
	@first_user = User.first

	erb :index
end

get '/signup' do
	# Protect '/signup' from unauthorized users
	redirect '/login'
end

	# Login Routes 
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
			redirect '/login'
		end
	end

# Admin Routes ---------------------------------------------------------------

get '/admin' do
	if session[:name]
		user = User.first(name: session[:name])
		@current_user = user
		@id = user.id
		@boss = true ? user.admin == true : false
	end
	
	@title = 'Dashboard'
	@admin = true ? @user : false

 	if @user && User.first(name: session[:name]).logged_in?(@user)
 		# Only render admin view if logged in
 		erb :admin
 	else 
 		# Redirect to '/login' if unauthorized user tries to access '/admin'
 		redirect '/login'
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
		
	# Taskbar
		# Update Personal Info
		post '/:id/update/email' do
			admin = User.first
			user = User.first(id: params[:id])


			if params[:email] != ""
				# Email change confirmation to new email address, cc: old email address
				Pony.mail 	to: 		"#{user.email}",
							cc: 		"#{params[:email]}",
            				from: 		"noreply@2Chez.com",
            				subject: 	"Email Change Confirmation",
            				body: 		erb(:email_email, layout: false, locals: { user: user, admin: admin })

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
					# Email confirmation every time password is changed
					Pony.mail 	to: 		"#{user.email}",
            					from: 		"noreply@2Chez.com",
            					subject: 	"#{user.name.capitalize}, your password has been changed",
            					body: 		erb(:password_email, layout: false, locals: { user: user, admin: admin })

					user.password = new_password
					user.save			

					halt 200, "password change success"
				else
					halt 500
					# Send email to user upon failed password change attempt
					Pony.mail 	to: 		"#{user.email}",
            					from: 		"noreply@2Chez.com",
            					subject: 	"Failed password change",
            					body: 		erb(:failed_password_email, layout: false, locals: { user: user, admin: admin })
				end
			end

			redirect '/admin'
		end

		# Manage Users
		post '/signup' do
			@user_exists = false
			admin = User.first

		 	@users.each { |user| @user_exists = true if params[:name] == user.name }

		 	if @user_exists
		 		halt 500, "#{params[:name].capitalize} is already registered"
		 	else
				user = User.new
				user.name = params[:name]
				user.email = params[:email]
				user.password = 'password'
				user.save

				# Send email to new user
				Pony.mail 	to:  		params[:email],
            				from:  		"noreply@2Chez.com",
            				subject:  	"Welcome to the big show, #{params[:name].capitalize}!",
            				body:  		erb(:new_user, layout: false, locals: { user: user, admin: admin })

            	# Send confirmation email to Todd
            	Pony.mail 	to:  		admin.email,
            				from:  		"noreply@2Chez.com",
            				subject:  	"Did you grant #{params[:name].capitalize} access to the 2Chez website?",
            				body:  		erb(:new_user_admin, layout: false, locals: { user: user, admin: admin })

				redirect '/menu'
			end
		end

		post '/user/delete' do
			admin = User.first
			user = User.first(name: params[:name])

			if user.name == session[:name] || user.admin
				halt 500
				redirect '/menu' 
			else
				user.destroy
				
				# Send confirmation email to Todd
            	Pony.mail 	to: 	 	admin.email,
            				from: 		"noreply@2Chez.com",
            				subject: 	"Deleted #{params[:name].capitalize}",
            				body: 		erb(:delete_user_admin, layout: false, locals: { user: user, admin: admin })
			
				redirect '/menu'
			end
		end

		# Manage Menu
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
		
		# Logout
		post '/logout' do
			session.destroy
			redirect '/'
		end


end