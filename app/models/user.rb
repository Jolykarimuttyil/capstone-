class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  
  has_many :recipes
  has_many :fridge_items 
  has_many :comments

  def as_json
    {
      id: id,
      name: name,
      email: email
    }
  end
end

