FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.paragraph }
    association :user
    association :story

    factory :invalid_comment do # child factory
      content { nil }
    end
  end
end
