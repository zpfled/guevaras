class MenuItemDraft < ActiveRecord::Base
  belongs_to :category
  belongs_to :menu

  def complete?
    category && description && menu && name && price
  end
end