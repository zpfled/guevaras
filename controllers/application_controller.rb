require 'grape'
require_relative '../helpers/params_helper'

class ApplicationController < Grape::API
  helpers ParamsHelper

  def current_user
    User.find(session[:id])
  end

end