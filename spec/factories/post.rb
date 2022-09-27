include ActionDispatch::TestProcess

FactoryBot.define do
  factory :post do
    user { create(:user) }
    images { [Rack::Test::UploadedFile.new('spec/fixtures/avatar.jpg', 'image/jpg')] }
  end
end
