
module MenuItemCreator

  def self.create(params)
    # res = Twilio::TwiML::Response.new do |r|
    #   r.Sms "Hey Z. \n\n\nThanks for the message 4!"
    # end

    # res
  # Create Flow

  # Posting to this endpoint creates a menu_item_draft with
  # identifier: :approved_phone_number_that_request_came_from
  # Create flow operates on this item and changes the appropriate
  # attrs depending on where in the process you are.
  # You can cancel the create process at anytime if you want.

  ## What menu is this item for?
  ## (Reply with the number of the correct menu)
  ## 1. Lunch
  ## 2. Dinner
  ## 3. Wine List
  ## 4. Cocktails
  ## 5. Small Plates

  ## What is this :item_type called?
  ## //response is string, parsed and smartly capitalized by server

  ## What category does :item_name fall into?
  ## (Reply with the number of the corrseponding category)
  ## 1. Loop
  ## 2. through
  ## 3. menu
  ## 4. categories

  ## How much does :item_name cost?
  ## //response is number (or float)

  ## Describe :item_name in 144 characters or less.
  ## Response is string, semi-smartly capitalized by server

  # (Delete menu_item_draft)

  # Save record as menu item, then present success message to user
  # Ok, :item_name has been added to the :item_category section of the
  # :item_menu menu, and is priced at $:item_price.
  # What would you like to do next?
  # (Reply with the number of the corresponding choice)
  # 1. Add another item to the menu.
  # 2. Change an existing menu item.
  # 3. Delete an item from the menu.
  end

  def self.unauthorized

  end
end