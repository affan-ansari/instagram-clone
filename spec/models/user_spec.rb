require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:posts).class_name('Post').dependent(:destroy) }
    it { is_expected.to have_many(:stories).class_name('Story').dependent(:destroy) }
    it { is_expected.to have_many(:comments).class_name('Comment').dependent(:destroy) }
    it { is_expected.to have_many(:likes).class_name('Like').dependent(:destroy) }
    it { is_expected.to have_many(:followings).class_name('Following').dependent(:destroy) }
    it { is_expected.to have_many(:followers).through(:followings) }
    it { is_expected.to have_one_attached(:image) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'custom validations' do
    let(:u1) { create(:user) }

    context 'When file is not an image of png, jpg, jpeg' do
      it 'is not valid' do
        u1.image.attach(
          io: File.open(Rails.root.join('spec/fixtures/test.pdf')), filename: 'test.pdf'
        )
        expect(u1.valid?).to be(false)
      end
    end

    context 'When file is an image' do
      it 'is valid' do
        u1.image.attach(
          io: File.open(Rails.root.join('spec/fixtures/avatar.jpg')), filename: 'avatar.jpg'
        )
        expect(u1.valid?).to be(true)
      end
    end
  end
end
