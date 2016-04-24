class MenuItem < ActiveRecord::Base
  belongs_to :category
  belongs_to :menu

  validates_presence_of :category,
                        :description,
                        :menu,
                        :name,
                        :price
end