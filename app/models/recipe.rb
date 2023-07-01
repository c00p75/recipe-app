class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods
  # Validations
  validates :name, presence: true, length: { maximum: 250 }
  validates :description, presence: true
end
