FactoryBot.define do
  factory :following do
    association :user
    follower { create(:user) }
  end
end
