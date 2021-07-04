require 'rails_helper'

RSpec.describe 'As a merchant.', type: :feature do
  describe 'When I visit my dashboard.' do 
    it 'I can see my name displayed.' do
      merchant = create(:merchant)

      visit "/merchants/#{merchant.id}/dashboard"

      expect(page).to contain(merchant.name)
    end
  end
end