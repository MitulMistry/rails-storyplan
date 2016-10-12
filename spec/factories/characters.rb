FactoryGirl.define do
  factory :character do
    name Faker::Superhero.name
    user_id Faker::Number.between(1, 10)
    bio Faker::Lorem.paragraph
    traits Faker::Lorem.sentence
  end
end
