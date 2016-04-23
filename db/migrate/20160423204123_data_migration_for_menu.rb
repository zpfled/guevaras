require_relative '../../models/menu'

class DataMigrationForMenu < ActiveRecord::Migration
  def change
    MENU_NAMES = ['lunch', 'dinner', 'wine', 'small plates', 'cocktail']

    MENU_NAMES.each do |menu_name|
      menu = Menu.create(name: menu_name)
      MenuItem.where(menu: menu_name).update_all(menu_id: menu.id)
    end
  end
end
