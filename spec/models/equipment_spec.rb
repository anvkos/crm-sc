require 'rails_helper'

RSpec.describe Equipment, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:kind) }

    it { is_expected.to validate_presence_of(:serial_number) }
  end
end
