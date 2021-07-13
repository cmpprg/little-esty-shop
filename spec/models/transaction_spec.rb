require 'rails_helper'

RSpec.describe Transaction do
  describe 'validations' do
    it { should validate_presence_of :credit_card_number }
    it { should validate_numericality_of :credit_card_number }
    it { should validate_presence_of :result }
    it { should define_enum_for :result }
  end

  describe 'relationships' do
    it { should belong_to :invoice }
  end

  describe 'methods' do
    xit 'can return all successful transactions' do
      transaction_1 = create(:transaction, result: 'success')
      transaction_2 = create(:transaction, result: 'success')
      transaction_3 = create(:transaction, result: 'failed')

      expect(Transaction.successful).to contain_exactly(transaction_1, transaction_2)
    end
  end
end