require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  def has_permission(permission)
    case permission
    when 'edit_menu'
      true
    when 'add_user'
      # check if admin?
      false
    else
      false
    end
  end

  def authenticate!(pw, session)
    if valid_password?(pw)
      session[:user_id] = id
    else
      raise 'Incorrect username or password'
    end
  end

  def valid_password?(password_try)
    password == password_try
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end