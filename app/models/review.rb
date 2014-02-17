class Review < ActiveRecord::Base
  validates :title, presence: true
  validates :review, presence: true
  validates :rating, presence: true
  
  belongs_to :apartment
  belongs_to :user
end