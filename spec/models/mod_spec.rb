require 'rails_helper'

RSpec.describe Mod, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:items).inverse_of(:mod) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:version) }
    it { is_expected.to allow_values('1.0', '1.1.0').for(:version) }
    it { is_expected.not_to allow_values('1.0a', 'hello').for(:version) }
  end
end
