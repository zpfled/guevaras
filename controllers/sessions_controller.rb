require_relative 'application_controller'

class SessionsController < ApplicationController
  helpers ParamsHelper
  helpers SessionsHelper

  version 'v1', using: :path
  format :json
  prefix :api

  resource :sessions do
    desc 'Login a user'
    post do
      user = User.find_by_email(session_params[:email])
      user.authenticate!(session_params[:password], session)

      return current_user
    end
  end
end