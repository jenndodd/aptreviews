class Apartment < ActiveRecord::Base
  validates :address, presence: true
  validates :unit, presence: true, uniqueness: { scope: :address }


  has_many :listings
  belongs_to :user
  has_many :reviews
end