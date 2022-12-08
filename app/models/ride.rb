class Ride < ApplicationRecord
  belongs_to :rider
  belongs_to :driver

  validates :origin, presence: true
end
