class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items

  validates :status, {
    presence: true
  }
  
  enum status: [:in_progress, :completed, :cancelled]
end