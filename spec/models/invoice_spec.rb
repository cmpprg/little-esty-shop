require 'rails_helper'

RSpec.describe Invoice do
  describe 'validations' do
    it { should validate_presence_of :status }
    it { should define_enum_for :status}
  end

  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
  end

  describe 'methods' do

  end
end