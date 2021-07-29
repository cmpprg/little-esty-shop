class Merchant::DashboardController < Merchant::BaseController

  def index
    @merchant = Merchant.find_by_id(params[:merchant_id])
    @items_ready_to_ship = items_ready_to_ship
  end

  private

    def items_ready_to_ship
      @merchant.items.joins(invoice_items: :invoice)
      .where.not(invoice_items: { status: 'shipped' })
    end
end