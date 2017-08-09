class Recipe < ApplicationRecord
  # Associations
  belongs_to :item, inverse_of: :recipe
  # has_many :ingredients, inverse_of: :recipe

  # Validations
  validates :item, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
end
