require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  def has_permission(permission)
    case permission
    when 'edit_menu'
      true
    when 'add_user'
      self.admin
    else
      false
    end
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end