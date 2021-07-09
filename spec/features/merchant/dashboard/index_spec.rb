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

    it 'I see the names of my top 5 customers, who have the largest number of
        successful transactions for my items' do
      
      merchant = create(:merchant)
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      customer_3 = create(:customer)
      customer_4 = create(:customer)
      customer_5 = create(:customer)
      customer_6 = create(:customer)
      customer_7 = create(:customer)

      # Create resources from transactions to merchants, switch customer 1 & 2
      # to ensure order is based on number of successful transactions and not
      # order in DB.
      7.times { create_all_resources_for(merchant, customer_2, 'success') } #create_all_resources_for method found in Helpers module ./spec/helpers
      6.times { create_all_resources_for(merchant, customer_1, 'success') }
      5.times { create_all_resources_for(merchant, customer_3, 'success') }
      4.times { create_all_resources_for(merchant, customer_4, 'success') }
      3.times { create_all_resources_for(merchant, customer_5, 'success') }
      2.times { create_all_resources_for(merchant, customer_6, 'success') }
      1.times { create_all_resources_for(merchant, customer_7, 'success') }
      # I want to ensure that no failed transactions are counted
      2.times do 
        create_all_resources_for(merchant, customer_1, 'failed')
        create_all_resources_for(merchant, customer_2, 'failed')
        create_all_resources_for(merchant, customer_3, 'failed')
        create_all_resources_for(merchant, customer_4, 'failed')
        create_all_resources_for(merchant, customer_5, 'failed')
      end
      
      visit(merchant_dashboard_index_path(merchant))

      within('#top-five-customers') do
        expect(page.all('.top-customer')[0]).to have_content("1. #{customer_2.first_name} #{customer_2.last_name} - 7 purchases")
        expect(page.all('.top-customer')[1]).to have_content("2. #{customer_1.first_name} #{customer_1.last_name} - 6 purchases")
        expect(page.all('.top-customer')[2]).to have_content("3. #{customer_3.first_name} #{customer_3.last_name} - 5 purchases")
        expect(page.all('.top-customer')[3]).to have_content("4. #{customer_4.first_name} #{customer_4.last_name} - 4 purchases")
        expect(page.all('.top-customer')[4]).to have_content("5. #{customer_5.first_name} #{customer_5.last_name} - 3 purchases")
      end
    end
  end
end