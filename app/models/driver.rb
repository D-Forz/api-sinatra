class Driver < ActiveRecord::Base
  has_many :transactions

  validates :username, presence: true, uniqueness: true
  validates :password, :location, presence: true
  validates :status, inclusion: { in: %w[AVAILABLE RIDE] }
end
