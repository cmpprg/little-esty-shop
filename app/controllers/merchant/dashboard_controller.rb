class Merchant::DashboardController < Merchant::BaseController

  def index
    @merchant = Merchant.find_by_id(params[:merchant_id])
    @top_five_customers = get_top_five_customers(@merchant)
  end

private

  def get_top_five_customers(merchant)
    merchant.top_five_customers
  end
end