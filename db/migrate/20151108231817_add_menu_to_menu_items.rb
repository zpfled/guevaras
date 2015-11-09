class AddMenuToMenuItems < ActiveRecord::Migration
  def change
    add_column :menu_items, :menu, :string, null: false
  end
end
