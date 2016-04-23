class Category < ActiveRecord::Base
  belongs_to :menu

  validates_presence_of :menu, :name
end