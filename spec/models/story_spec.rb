require 'rails_helper'

RSpec.describe Story, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user).class_name('User') }
    it { is_expected.to have_one_attached(:image) }
  end

  describe 'custom validations' do
    let(:u1) { build(:user) }
    let(:s1) { build(:story, user: u1) }

    it 'Image exists' do
      expect(s1.valid?).to be(true)
    end

    it 'Image does not exists' do
      s1.image.purge
      expect(s1.valid?).to be(false)
    end

    it 'File is not an image of png, jpg, jpeg' do
      s1.image.purge
      s1.image.attach(
        io: File.open(Rails.root.join('spec/fixtures/test.pdf')), filename: 'test.pdf'
      )
      expect(s1.valid?).to be(false)
    end
  end
end
