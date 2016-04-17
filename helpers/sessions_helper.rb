require 'grape'

module SessionsHelper
  extend Grape::API::Helpers

  def current_user
    p User.find(session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def session
    if env['rack.session']
      env['rack.session']
    else
      env['rack.session'] = {}
    end
  end
end