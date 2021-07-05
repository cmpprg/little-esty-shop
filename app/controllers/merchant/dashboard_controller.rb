class Merchant::DashboardController < Merchant::BaseController

  def index
    @merchant = Merchant.find_by_id(params[:merchant_id])
  end
end