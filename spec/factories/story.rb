FactoryBot.define do
  factory :story do
    user { create(:user) }
    image { Rack::Test::UploadedFile.new('spec/fixtures/avatar.jpg', 'image/jpg') }
  end
end
