class Apartment < ActiveRecord::Base
  validates :address, presence: true
  validates :unit, presence: true

  has_many :listings
end