require 'grape'

module ParamsHelper
  extend Grape::API::Helpers

  def session_params
    email = params[:user].fetch(:email)
    password = params[:user].fetch(:password)
    { email: email, password: password }
  end

  def user_params
    email = params[:user].fetch(:email)
    name = params[:user].fetch(:name)
    password = params[:user].fetch(:password)
    { email: email, name: name, password: password }
  end
end