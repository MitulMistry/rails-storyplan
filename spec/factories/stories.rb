FactoryGirl.define do
  factory :story do
    name { Faker::Book.title }
    target_word_count { Faker::Number.between(1, 100) * 1000 }
    overview { Faker::Lorem.paragraph }
    association :user

    factory :invalid_story do # child factory
      name nil
    end
  end
end
