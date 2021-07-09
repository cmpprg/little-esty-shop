require 'rails_helper'

RSpec.describe Customer do
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe 'relationships' do
    it { should have_many :invoices }
  end

  describe 'methods' do
    it 'can return it\'s full name' do
      first_name = 'robert'
      last_name = 'frost'
      full_name = 'robert frost'
      customer = create(:customer, first_name: first_name, last_name: last_name)

      expect(customer.full_name).to eql(full_name)
    end
  end
end