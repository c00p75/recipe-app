class Food < ApplicationRecord
  belongs_to :user
  has_many :recipes
  validates :name, presence: true
  validates :measurement_unit, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
