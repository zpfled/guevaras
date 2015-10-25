class MenuItem < ActiveRecord::Base
  validates_presence_of :category, :description, :menu, :name, :price
end