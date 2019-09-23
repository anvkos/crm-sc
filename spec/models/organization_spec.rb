require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:kind) }

    it { is_expected.to validate_presence_of(:inn) }
    it { is_expected.to validate_numericality_of(:inn).only_integer }

    it { is_expected.to validate_presence_of(:ogrn) }
    it { is_expected.to validate_numericality_of(:ogrn).only_integer }
  end
end
