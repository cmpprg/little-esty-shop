class Transaction < ApplicationRecord
  belongs_to :invoice

  validates :credit_card_number, {
    presence: true,
    numericality: { integer_only: true }
  }

  validates :result, {
    presence: true,
  }

  enum result: [:failed, :success]
end