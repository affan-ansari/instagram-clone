FactoryBot.define do
  factory :post do
    user { create(:user) }
    images { Rack::Test::UploadedFile.new('app/assets/images/avatar.jpg', 'image/jpg') }
  end
end
