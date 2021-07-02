class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates :quantity, {
    presence: true,
    numericality: { integer_only: true }
  }

  validates :unit_price, {
    presence: true,
    numericality: { integer_only: true }
  }

  validates :status, {
    presence: true,
  }

  enum status: [:pending, :packaged, :shipped]
end