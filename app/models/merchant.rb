class Merchant < ApplicationRecord
  has_many :items
  
  validates :name, {
    presence: true
  }

  def top_five_customers
    tfc = Customer.joins(invoices: [:transactions, invoice_items: {item: :merchant}])
    tfc = tfc.where(transactions: {result: Transaction.results[:success]}, merchants: {id: self})
    tfc = tfc.select('customers.* , COUNT(transactions.id) as quantity_successful_transactions')
    tfc = tfc.group('customers.id').order('quantity_successful_transactions DESC').limit(5)
  end

  def items_ready_to_ship
    self.items.joins(invoice_items: :invoice)
    .where.not(invoice_items: { status: 'shipped' })
  end
end