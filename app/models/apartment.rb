class Apartment < ActiveRecord::Base
  validates :number, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true

  validates :unit, presence: true
  validates_uniqueness_of :unit, scope: [:number, :street, :city, :state]


  def address
    numbstreet = [number, street].compact.join(' ')
    [numbstreet, city, state].compact.join(', ')
  end

  geocoded_by :address   # can also be an IP address
  after_validation :geocode 


  has_many :listings
  belongs_to :user
  has_many :reviews
end