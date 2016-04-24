require 'grape'
require_relative '../../../helpers/twilio_helper'
require_relative '../../../services/menu_item_service'

AUTHORIZED_USERS = [13095736404]


class MenuItemsController < Grape::API
  include TwilioHelper

  version 'v1', using: :path
  prefix :api
  default_format :json

  resource :menu_items do
    # Create
    desc 'Create a new menu item'
    # TODO: This will be "post do" for real, just using "get :create" for development
    # TODO: Url for the phone will need to be /api/v1/menu_items.xml
    # post do
    get :create do
      begin
        authorize!(params)
        MenuItemService.create(create_params(params))
      rescue
        render_unauthorized_error
      end
    end

    # Read
    desc 'Get all menu items'
    get do
      MenuItem.all
    end

    desc 'Get lunch menu'
    get :lunch do
      MenuItem.where(menu_id: Menu.find_by(name: 'lunch').id)
    end

    desc 'Get small plates menu'
    get :small_plates do
      MenuItem.where(menu_id: Menu.find_by(name: 'small plates').id)
    end

    desc 'Get wine list'
    get :wine do
      MenuItem.where(menu_id: Menu.find_by(name: 'wine').id)
    end

    desc 'Get dinner menu'
    get :dinner do
      MenuItem.where(menu_id: Menu.find_by(name: 'dinner').id)
    end

    desc 'Get cocktail list'
    get :cocktail do
      MenuItem.where(menu_id: Menu.find_by(name: 'cocktail').id)
    end

    # Update

    # Destroy
  end


  helpers do
    def authorize!(params)
      authorized = AUTHORIZED_USERS.include? create_params(params)[:from]
      raise Error unless authorized
    end

    def create_params(params)
      # SAMPLE PARAMS FROM TWILIO REQUEST
      # {
      #   "ToCountry"=>"US",
      #   "ToState"=>"IL",
      #   "SmsMessageSid"=>"SM7d682c3d6a7ce0c1ecbc9bf920994276",
      #   "NumMedia"=>"0",
      #   "ToCity"=>"PEORIA",
      #   "FromZip"=>"61603",
      #   "SmsSid"=>"SM7d682c3d6a7ce0c1ecbc9bf920994276",
      #   "FromState"=>"IL",
      #   "SmsStatus"=>"received",
      #   "FromCity"=>"PEORIA",
      #   "Body"=>"Posting, 34",
      #   "FromCountry"=>"US",
      #   "To"=>"+13092731511",
      #   "ToZip"=>"61603",
      #   "NumSegments"=>"1",
      #   "MessageSid"=>"SM7d682c3d6a7ce0c1ecbc9bf920994276",
      #   "AccountSid"=>"ACaaafb0a1094b5adf37d08405abbb18bf",
      #   "From"=>"+13095736404",
      #   "ApiVersion"=>"2010-04-01"
      # }
      body = params.fetch('Body')
      from = params.fetch('From')

      return {
        body: body,
        from: from.to_i
      }
    end

    def render_unauthorized_error
      error_response = Twilio::TwiML::Response.new do |r|
        r.Sms "Uh oh! It looks like you're trying to update the menu from an unauthorized phone.\n
              \n
              If you think you should not be receiving this message,
              call Zach and he'll get you sorted out."
      end

      error_response
    end
  end
end