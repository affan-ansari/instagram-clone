require 'rails_helper'

RSpec.describe Following, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user).class_name('User') }
    it { is_expected.to belong_to(:follower).class_name('User') }
  end

  describe 'custom validations' do
    let(:f1) { create(:following) }
    let(:f2) { create(:following) }

    it 'User and follower are not same' do
      expect(f1.valid?).to be(true)
    end

    it 'User and follower are same' do
      f1.follower = f1.user
      expect(f1.valid?).to be(false)
    end

    it 'User cannot follow more than once' do
      f2.user = f1.user
      f2.follower = f1.follower
      expect(f2.valid?).to be(false)
    end
  end

  describe 'model functions' do
    let(:u1) { build(:user) }
    let(:f1) { build(:following, user: u1) }

    it 'assign_accept_status returns true if user is public' do
      expect(f1.assign_accept_status(u1)).to be(true)
    end

    it 'assign_accept_status returns false if user is private' do
      u1.is_public = false
      expect(f1.assign_accept_status(u1)).to be(false)
    end
  end
end
