class DropMenuColumnFromMenuItems < ActiveRecord::Migration
  def change
    remove_column :menu_items, :menu
  end
end
