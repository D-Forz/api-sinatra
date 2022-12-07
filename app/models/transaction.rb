class Transaction < ActiveRecord::Base
  belongs_to :rider
  belongs_to :driver

  validates :payment_method, :payment_id, :reference, :amount, :currency, :rider_email, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :currency, inclusion: { in: %w[COP] }
  validates :payment_method, inclusion: { in: %w[CARD] }
end
