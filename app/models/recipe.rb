class Recipe < ApplicationRecord
  belongs_to :user 
  has_many :ingredents
  has_many :directions  
  has_many :comments
end
