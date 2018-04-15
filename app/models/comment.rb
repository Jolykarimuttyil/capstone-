class Comment < ApplicationRecord
  belongs_to :recipes
  belongs_to :user
end
