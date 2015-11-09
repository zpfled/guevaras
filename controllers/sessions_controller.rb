require_relative 'application_controller'

class SessionsController < ApplicationController
  version 'v1', using: :path
  format :json
  prefix :api

  resource :sessions do

    # Login
    desc 'Login a user'
    params do
      requires :username, type: String, desc: 'Your username'
      requires :password, type: String, desc: 'Your password'
    end
    post do
      user = User.find_by_email(params[:email])
      authenticate!

    end
  end

private

  def authenticate!
    user = User.find_by_email(params[:email])
    if user.password == params[:password]
      return true
    else
      raise 'Incorrect username or password'
    end
  end
end