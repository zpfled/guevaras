require 'grape'

class MenuItemsController < Grape::API
  version 'v1', using: :path
  format :json
  prefix :api

  resource :menu_items do
    desc 'List all menu items'
    get do
      MenuItem.all
    end

    desc 'Return the dinner menu'
    get :dinner do
      MenuItem.where(menu: 'dinner')
    end

    desc 'Return the lunch menu'
    get :lunch do
      MenuItem.where(menu: 'lunch')
    end

    desc 'Return the small plates menu'
    get :small_plates do
      MenuItem.where(menu: 'small_plates')
    end

    desc 'Return the wine list'
    get :wine do
      MenuItem.where(menu: 'wine')
    end
  end
end