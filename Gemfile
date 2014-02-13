source "https://rubygems.org"
ruby "2.0.0"
gem 'sinatra'
gem 'data_mapper'
gem 'shotgun'
gem 'bcrypt-ruby',			require: 'bcrypt'
gem 'multi_json', '1.8.4'

group :test do
	gem 'rspec'
	gem 'rack-test'
end

group :development do
	gem 'guard'
	gem 'guard-livereload', require: false
	gem 'sqlite3'
	gem 'dm-sqlite-adapter'
end

group :production do
	gem 'pg'
	gem 'dm-postgres-adapter'
end