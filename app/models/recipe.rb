class Recipe < ApplicationRecord
  belongs_to :user
  has_many :foods
  # Validations
  validates :name, presence: true, length: { maximum: 250 }
  validates :description, presence: true
end
