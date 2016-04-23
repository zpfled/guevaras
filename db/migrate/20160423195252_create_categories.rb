class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.belongs_to :menu

      t.timestamps
    end
  end
end
