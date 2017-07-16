FactoryGirl.define do
  factory :task do
    title { Faker::Lorem.word }
    description { Faker::Lorem.word }
    completed_at nil
    board_id nil
  end
end