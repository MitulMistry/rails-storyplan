FactoryGirl.define do
  factory :character do
    name { Faker::Superhero.name }
    bio { Faker::Lorem.paragraph }
    traits { Faker::Lorem.sentence }
    association :user

    factory :invalid_character do
      name nil
    end
  end
end
