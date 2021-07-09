module Helpers
  def create_all_resources_for(merchant, customer, result)
    build(:invoice_item) do |ii|
      ii.invoice.customer = customer
      ii.item.merchant = merchant
      create(:transaction, invoice: ii.invoice, result: result)
    end.save
  end
end