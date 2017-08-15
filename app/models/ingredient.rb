class Ingredient < ApplicationRecord
  # Associations
  belongs_to :recipe, inverse_of: :ingredients
  belongs_to :item

  # Validations
  validates :recipe, :item, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  def to_s
    "(#{quantity}x) #{item}"
  end
end
