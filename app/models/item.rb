class Item < ApplicationRecord
  # Associations
  belongs_to :mod, inverse_of: :items
  has_one :recipe, inverse_of: :item
  has_many :ingredients, through: :recipe

  # Validations
  validates :mod, :name, :identifier, :icon, presence: true
  validate :valid_icon_url

  def to_s
    name
  end

  private

  def valid_icon_url
    return if icon.blank?

    errors.add(:icon, 'is not a valid image URL') unless valid_url?(icon) && icon.match?(/\.(jpg|png)\z/)
  end

  def valid_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end
end
