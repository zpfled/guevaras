class CreateMenuItemDrafts < ActiveRecord::Migration
  def change
    create_table :menu_item_drafts do |t|
      t.text :description
      t.string :name
      t.integer :phone_number
      t.float :price

      t.belongs_to :category
      t.belongs_to :menu

      t.timestamps
    end
  end
end
