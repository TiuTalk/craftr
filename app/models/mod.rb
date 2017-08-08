class Mod < ApplicationRecord
  # Validations
  validates :name, :version, presence: true
  validates :version, format: { with: /\A(\d+\.){0,2}\d+\z/ }
end
