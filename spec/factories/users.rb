FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name(nil, %w(_ -)) }
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(8, 20) }
    bio { Faker::Lorem.paragraph }
  end
end
