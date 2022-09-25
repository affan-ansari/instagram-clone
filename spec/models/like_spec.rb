require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user).class_name('User') }
    it { is_expected.to belong_to(:post).class_name('Post') }
  end

  describe 'custom validations' do
    let(:l1) { create(:like) }
    let(:l2) { create(:like) }

    it 'User cannot like more than once' do
      l2.user = l1.user
      l2.post = l1.post
      expect(l2.valid?).to be(false)
    end
  end
end
