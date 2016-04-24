class CategoryDataMigration < ActiveRecord::Migration
  def change
    MenuItem.all.each do |item|
      cat_name = item.category.downcase.gsub('-', ' ')
      if existing = Category.find_by(name: cat_name, menu_id: item.menu_id)
        item.category_id = existing.id
      else
        item.category_id = Category.create(name: cat_name, menu_id: item.menu_id).id
      end

      item.save
    end
  end
end

