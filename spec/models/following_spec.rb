require 'rails_helper'

RSpec.describe Following, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:follower) }
  end

  describe 'custom validations' do
    let(:f1) { build(:following) }
    let(:f2) { build(:following) }

    context 'When User and follower are not same' do
      it 'is valid' do
        expect(f1.valid?).to be(true)
      end
    end

    context 'When user and follower are same' do
      it 'is not valid' do
        f1.follower = f1.user
        expect(f1.valid?).to be(false)
      end
    end

    context 'When user cannot follow more than once' do
      let(:f3) { create(:following) }
      let(:f4) { create(:following) }

      it 'is not valid' do
        f4.user = f3.user
        f4.follower = f3.follower
        expect(f4.valid?).to be(false)
      end
    end
  end

  describe 'model functions' do
    let(:u1) { build(:user) }
    let(:f1) { build(:following, user: u1) }

    context 'When user is public' do
      it 'assign_accept_status returns true' do
        expect(f1.assign_accept_status(u1)).to be(true)
      end
    end

    context 'Whe user is private' do
      it 'assign_accept_status returns false' do
        u1.is_public = false
        expect(f1.assign_accept_status(u1)).to be(false)
      end
    end
  end
end
