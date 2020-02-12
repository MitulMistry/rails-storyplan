FactoryBot.define do
  factory :story do
    name { Faker::Book.title }
    target_word_count { Faker::Number.between(from: 1, to: 100) * 1000 }
    overview { Faker::Lorem.paragraph }
    association :user

    factory :invalid_story do # child factory
      name { nil }
    end

    factory :story_with_cover do # use test file for attached Active Storage image
      cover { fixture_file_upload(Rails.root.join("spec", "support", "assets", "test_story_cover_400x625.png"), "image/png") }
    end

    factory :story_with_uploaded_cover do # use this child factory when making a post/patch request with attributes_for
      cover { fixture_file_upload(Rails.root.join("spec", "support", "assets", "test_story_cover_400x625.png"), "image/png") }
    end

    factory :invalid_story_with_uploaded_cover do # use this child factory when making a post/patch request with attributes_for
      cover { fixture_file_upload(Rails.root.join("spec", "support", "assets", "test_story_cover_400x625.png"), "image/png") }
      name { nil }
    end
  end
end
