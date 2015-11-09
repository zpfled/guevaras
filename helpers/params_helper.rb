require 'grape'
require 'action_controller/metal/strong_parameters'

module ParamsHelper
  extend Grape::API::Helpers

  def user_params
    ActionController::Parameters.new(params)
      .require(:user)
      .permit(:email, :name, :password)
  end
end