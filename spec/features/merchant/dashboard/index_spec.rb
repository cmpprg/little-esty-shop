require 'rails_helper'

RSpec.describe 'As a merchant.', type: :feature do
  describe 'When I visit my dashboard.' do 
    it 'I can see my name displayed.' do
      merchant = create(:merchant)
      
      visit "/merchants/#{merchant.id}/dashboard" #merchant_dashboard_index_path
      
      within '#merchant-name' do
        expect(page).to have_content(merchant.name)
      end
    end
    
    it 'I can see and use a link to merchant items index' do
      merchant = create(:merchant)

      visit(merchant_dashboard_index_path(merchant))

      within '.dashboard-links' do
        click_link('My Items')
      end

      expect(current_path).to eq("/merchants/#{merchant.id}/items")
    end

    it 'I can see and use a link to merchant invoices index' do
      merchant = create(:merchant)

      visit(merchant_dashboard_index_path(merchant))

      within '.dashboard-links' do
        click_link('My Invoices')
      end

      expect(current_path).to eq("/merchants/#{merchant.id}/invoices")
    end
  end
end