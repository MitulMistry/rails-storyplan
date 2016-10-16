FactoryGirl.define do
  factory :genre do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
  end
end
