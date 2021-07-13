class Merchant::DashboardController < Merchant::BaseController

  def index
    @merchant = Merchant.find_by_id(params[:merchant_id])
    @top_five_customers = get_top_five_customers(@merchant)
  end

private

  def get_top_five_customers(merchant)
    tfc = Customer.joins(invoices: [:transactions, invoice_items: {item: :merchant}])
    tfc = tfc.where('transactions.result = 1', 'merchants.id = ?', merchant)
    tfc = tfc.select('customers.first_name || \' \' || customers.last_name as full_name, COUNT(transactions.id) as quantity_successful_transactions')
    tfc = tfc.group('full_name').order('quantity_successful_transactions DESC').limit(5)
    # require 'pry';binding.pry
  end
end