FactoryGirl.define do
  factory :board do
    title { Faker::Lorem.word }
    description { Faker::Lorem.word }
  end
end