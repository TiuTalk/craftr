require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:recipe).inverse_of(:ingredients) }
    it { is_expected.to belong_to(:item) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:recipe) }
    it { is_expected.to validate_presence_of(:item) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:quantity).only_integer.is_greater_than(0) }
  end
end
