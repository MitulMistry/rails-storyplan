FactoryGirl.define do
  factory :comment do
    content Faker::Lorem.paragraph
  end
end
