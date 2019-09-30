require 'rails_helper'

RSpec.describe Staff, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:fullname) }
    it { is_expected.to validate_length_of(:fullname).is_at_least(5) }
  end
end
