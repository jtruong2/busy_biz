FactoryBot.define do
  factory :search do
    sequence :criteria, 10 do |n|
      "term #{n}"
    end
  end
end
