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
    x = self.items.joins(invoice_items: :invoice)
    .where.not(invoice_items: { status: 'shipped' })
    .select('items.name, invoices.id as invoice_id, invoice_items.id as invoice_item_id')
    .select('invoices.created_at as invoice_created_at')
    .order('invoices.created_at ASC')
  end
end