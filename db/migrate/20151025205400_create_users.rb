class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.boolean :admin, default: false
      t.string :email, null: false
      t.string :name, null: false
      t.string :password_hash, null: false

      t.timestamps null: false
    end
  end
end