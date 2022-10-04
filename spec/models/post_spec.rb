require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user).class_name('User') }
    it { is_expected.to have_many(:comments).class_name('Comment') }
    it { is_expected.to have_many(:likes).class_name('Like') }
    it { is_expected.to have_many_attached(:images) }
  end

  describe 'custom validations' do
    let(:u1) { build(:user) }
    let(:p1) { build(:post, user: u1) }

    context 'When at least one Image exists' do
      it 'is valid' do
        expect(p1.valid?).to be(true)
      end
    end

    context 'When One or more images do not exist' do
      it 'is valid' do
        p1.images.purge
        expect(p1.valid?).to be(false)
      end
    end

    context 'When one or more file is not an image of png, jpg, jpeg' do
      it 'is not valid' do
        p1.images.purge
        p1.images.attach(io: File.open(Rails.root.join('spec/fixtures/test.pdf')), filename: 'test.pdf')
        p1.images.attach(io: File.open(Rails.root.join('spec/fixtures/avatar.jpg')), filename: 'avatar.jpg')
        expect(p1.valid?).to be(false)
      end
    end

    context 'When one or more file is an image' do
      it 'is valid' do
        p1.images.purge
        p1.images.attach(io: File.open(Rails.root.join('spec/fixtures/avatar.jpg')), filename: 'avatar.jpg')
        p1.images.attach(io: File.open(Rails.root.join('spec/fixtures/avatar.jpg')), filename: 'avatar.jpg')
        expect(p1.valid?).to be(true)
      end
    end

    context 'When more then 10 images attached' do
      it 'is not valid' do
        p1.images.purge
        11.times do
          p1.images.attach(io: File.open(Rails.root.join('spec/fixtures/avatar.jpg')), filename: 'avatar.jpg')
        end
        expect(p1.valid?).to be(false)
      end
    end
  end
end
