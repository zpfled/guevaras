require 'spec_helper'

describe TwilioHelper do
  describe '#parse_body' do
    it 'returns a hash with action, menu, item, price, and description values' do
      params = {
        'Body' => 'action: add, menu: lunch, item: Shark Sandwich, price: 10, description: yum!'
      }

      parsed = TwilioHelper.parse_body(params)
      expect(parsed['action']).to eq 'add'
      expect(parsed['menu']).to eq 'lunch'
      expect(parsed['item']).to eq 'Shark Sandwich'
      expect(parsed['price']).to eq '10'
      expect(parsed['description']).to eq 'yum!'
    end
  end
end