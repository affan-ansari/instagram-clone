FactoryBot.define do
  factory :following do
    user { create(:user) }
    follower { create(:user) }
  end
end
