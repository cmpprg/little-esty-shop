require 'rails_helper'

RSpec.describe 'As a merchant.', type: :feature do
  describe 'When I visit my dashboard.' do 
    it 'I can see my name displayed.' do
      merchant = create(:merchant)

      visit "/merchants/#{merchant.id}/dashboard"

      within '#merchant-name' do
        expect(page).to have_content(merchant.name)
      end
    end

    xit 'I can see links to both merchant items index and merchant invoices index' do
      require 'pry';binding.pry
    end
  end
end