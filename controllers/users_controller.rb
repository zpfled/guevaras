require_relative 'application_controller'

class UsersController < ApplicationController
  helpers ParamsHelper

  version 'v1', using: :path
  format :json
  prefix :api

  resource :users do
    desc 'Create a user account'
    post do
      user = User.new(user_params)
      user.password = user_params[:password]
      user.save!
      user
    end

    # Login
    desc 'Login a user'
    post :login do
      login(user_from_params) if they_have_the_right_password!
      rescue_from :all do |e|
        error! e.message
      end
    end
  end

private

  def login(user)
    session[:id] = user.id
  end

  def they_have_the_right_password!(user)
    if user_from_params.password == user_params[:password]
      return user_from_params
    else
      raise 'Incorrect username or password'
    end
  end

  # TODO: make this not be a lookup every time, but it's not a big deal since
  # this action will nearly never be used - ZP
  def user_from_params
    User.find(email: user_params[:email])
  end
end