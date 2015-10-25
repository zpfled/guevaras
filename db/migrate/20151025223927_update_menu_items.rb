class UpdateMenuItems < ActiveRecord::Migration
  def change
    add_column :menu_items, :category, :string, null: false
    add_column :menu_items, :description, :string, null: false
    add_column :menu_items, :name, :string, null: false
    add_column :menu_items, :price, :integer, null: false
  end
end
