FactoryBot.define do
  factory :user do
    sequence :username, 10 do |n|
      "user#{n}"
    end
    password { "MyString" }
  end
end
