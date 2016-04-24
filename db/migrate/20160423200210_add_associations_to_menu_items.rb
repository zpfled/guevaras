class AddAssociationsToMenuItems < ActiveRecord::Migration
  def change
    add_column :menu_items, :category_id, :integer
    add_column :menu_items, :menu_id, :integer
  end
end
