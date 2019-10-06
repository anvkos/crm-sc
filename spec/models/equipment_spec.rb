require 'rails_helper'

RSpec.describe Equipment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:type_equipment) }
    it { is_expected.to belong_to(:organization) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:serial_number) }
  end
end
