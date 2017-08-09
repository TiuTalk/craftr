class Mod < ApplicationRecord
  # Associations
  has_many :items, inverse_of: :mod

  # Validations
  validates :name, :version, presence: true
  validates :version, format: { with: /\A(\d+\.){0,2}\d+\z/ }
end
