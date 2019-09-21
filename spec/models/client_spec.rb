require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:fullname) }
    it { is_expected.to validate_length_of(:fullname).is_at_least(5) }

    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_numericality_of(:phone).only_integer }
    describe 'phone uniqueness' do
      subject { build(:client) }

      it { is_expected.to validate_uniqueness_of(:phone) }
    end

    describe 'email uniqueness' do
      subject { build(:client) }

      it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    end
  end

  describe '#valid_uniqueness?' do
    let!(:another_client) { create(:client) }

    it 'returns true' do
      client = build(:client)
      expect(client.valid_uniqueness?).to eq true
    end

    context 'when returns false' do
      it 'email already exists' do
        client = build(:client, email: another_client.email)
        expect(client.valid_uniqueness?).to eq false
      end

      it 'phone already exists' do
        client = build(:client, phone: another_client.phone)
        expect(client.valid_uniqueness?).to eq false
      end
    end
  end
end
