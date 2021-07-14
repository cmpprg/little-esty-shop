class Merchant::DashboardController < Merchant::BaseController

  def index
    @merchant = Merchant.find_by_id(params[:merchant_id])
    @top_five_customers = get_top_five_customers(@merchant)
  end

private

  def get_top_five_customers(merchant)
    tfc = Customer.joins(invoices: [:transactions, invoice_items: {item: :merchant}])
    tfc = tfc.where(transactions: {result: Transaction.results[:success]}, merchants: {id: merchant.id})
    tfc = tfc.select('customers.* , COUNT(transactions.id) as quantity_successful_transactions')
    tfc = tfc.group('customers.id').order('quantity_successful_transactions DESC').limit(5)
  end
end