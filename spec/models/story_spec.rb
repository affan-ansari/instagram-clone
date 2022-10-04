require 'rails_helper'

RSpec.describe Story, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user).class_name('User') }
    it { is_expected.to have_one_attached(:image) }
  end

  describe 'custom validations' do
    let(:u1) { build(:user) }
    let(:s1) { build(:story, user: u1) }

    context 'When image exists' do
      it 'is valid' do
        expect(s1.valid?).to be(true)
      end
    end

    context 'When image does not exists' do
      it 'is not valid' do
        s1.image.purge
        expect(s1.valid?).to be(false)
      end
    end

    context 'When file is not an image of png, jpg, jpeg' do
      it 'is not valid' do
        s1.image.purge
        s1.image.attach(
          io: File.open(Rails.root.join('spec/fixtures/test.pdf')), filename: 'test.pdf'
        )
        expect(s1.valid?).to be(false)
      end
    end
  end
end
