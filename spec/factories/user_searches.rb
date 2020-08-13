FactoryBot.define do
  factory :user_search do
    association :user
    association :search
  end
end
