FactoryBot.define do
  factory :character do
    name { Faker::Superhero.name }
    bio { Faker::Lorem.paragraph }
    traits { Faker::Lorem.sentence }
    association :user

    factory :invalid_character do
      name { nil }
    end

    factory :character_with_portrait do # use test file for attached Active Support image
      portrait { Rack::Test::UploadedFile.new(Rails.root.join("spec", "support", "assets", "test_character_portrait_400.png"), "image/png") }
    end

    factory :character_with_uploaded_portrait do # use this child factory when making a post/patch request with attributes_for
      portrait { Rack::Test::UploadedFile.new(Rails.root.join("spec", "support", "assets", "test_character_portrait_400.png"), "image/png") }
    end

    factory :invalid_character_with_uploaded_portrait do # use this child factory when making a post/patch request with attributes_for
      portrait { Rack::Test::UploadedFile.new(Rails.root.join("spec", "support", "assets", "test_character_portrait_400.png"), "image/png") }
      name { nil }
    end
  end
end
