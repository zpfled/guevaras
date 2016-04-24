require_relative '../../models/menu'

class DataMigrationForMenu < ActiveRecord::Migration
  def change
    menu_names = ['lunch', 'dinner', 'wine', 'small plates', 'cocktail']

    menu_names.each do |menu_name|
      menu = Menu.create(name: menu_name)
      MenuItem.where(menu: menu_name).update_all(menu_id: menu.id)
    end
  end
end
