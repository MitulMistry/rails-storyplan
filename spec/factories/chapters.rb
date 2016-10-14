FactoryGirl.define do
  factory :chapter do
    name Faker::Book.title
    objective Faker::Lorem.sentence
    target_word_count (Faker::Number.between(1, 100) * 200)
    overview Faker::Lorem.paragraph
    currently_writing = true if Faker::Number.between(1, 3) == 1
  end
end
