class DropCategoryColumnFromMenu < ActiveRecord::Migration
  def change
    remove_column :menu_items, :category
  end
end
