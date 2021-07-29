module MerchantHelper
  def invoice_datetime_format(datetime)
    datetime.strftime('%A, %B %d, %Y')
  end
end