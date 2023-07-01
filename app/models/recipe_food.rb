class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  # Validations
  validates :quantity, presence: true
end
