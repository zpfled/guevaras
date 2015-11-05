require 'grape'

class MenuItemsController < Grape::API
  version 'v1', using: :path
  format :json
  prefix :api

  resource :menu_items do
    desc 'Get all menu items'
    get do
      MenuItem.all
    end

    desc 'Get lunch menu'
    get :lunch do
      MenuItem.where(menu: 'lunch')
    end

    desc 'Get small plates menu'
    get :small_plates do
      MenuItem.where(menu: 'small plates')
    end

    desc 'Get wine list'
    get :wine do
      MenuItem.where(menu: 'wine')
    end

    desc 'Get dinner menu'
    get :dinner do
      MenuItem.where(menu: 'dinner')
    end
  end
end