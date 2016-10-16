FactoryGirl.define do
  factory :comment do
    content { Faker::Lorem.paragraph }
    association :user
    association :story
  end
end
