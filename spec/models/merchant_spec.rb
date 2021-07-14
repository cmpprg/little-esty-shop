require 'rails_helper'

RSpec.describe Merchant do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :items }
  end

  describe 'methods' do
    it 'can return top five customers, most successful transactions' do
      merchant = create(:merchant)
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      customer_3 = create(:customer)
      customer_4 = create(:customer)
      customer_5 = create(:customer)
      customer_6 = create(:customer)
      customer_7 = create(:customer)

      
      7.times { create_all_resources_for(merchant, customer_2, 'success') } #create_all_resources_for method found in Helpers module ./spec/helpers
      6.times { create_all_resources_for(merchant, customer_1, 'success') }
      5.times { create_all_resources_for(merchant, customer_3, 'success') }
      4.times { create_all_resources_for(merchant, customer_4, 'success') }
      3.times { create_all_resources_for(merchant, customer_5, 'success') }
      2.times { create_all_resources_for(merchant, customer_6, 'success') }
      1.times { create_all_resources_for(merchant, customer_7, 'failed') }

      top_five = [
        customer_2,
        customer_1,
        customer_3,
        customer_4,
        customer_5,
      ]

      expect(merchant.top_five_customers).to eq(top_five)
    end
  end
end