FactoryGirl.define do
  factory :user do
    username Faker::Internet.user_name
    full_name Faker::Name.name
    email Faker::Internet.email
    password "password"
    bio Faker::Lorem.paragraph
  end
end
