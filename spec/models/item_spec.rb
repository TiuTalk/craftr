require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:mod) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:identifier) }
    it { is_expected.to validate_presence_of(:icon) }
    it { is_expected.to allow_values('http://example.com/image.jpg', 'http://example.com/image.png').for(:icon) }
    it { is_expected.not_to allow_values('hello', 'hello.png').for(:icon) }
  end
end