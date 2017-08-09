require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:item).inverse_of(:recipe) }
    xit { is_expected.to have_many(:ingredients).inverse_of(:recipe) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:item) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:quantity).only_integer.is_greater_than(0) }
  end
end
