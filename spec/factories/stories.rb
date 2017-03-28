FactoryGirl.define do
  factory :story do
    name { Faker::Book.title }
    target_word_count { Faker::Number.between(1, 100) * 1000 }
    overview { Faker::Lorem.paragraph }
    association :user
    cover { File.new("#{Rails.root}/spec/support/fixtures/images/test_story_cover_400x625.png") }

    factory :invalid_story do # child factory
      name nil
    end

    factory :story_with_uploaded_cover do #use this child factory when making a post/patch request with attributes_for
      cover { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/fixtures/images/test_story_cover_400x625.png", "image/png") } #issues multi-part request
    end

    factory :invalid_story_with_uploaded_cover do #use this child factory when making a post/patch request with attributes_for
      cover { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/fixtures/images/test_story_cover_400x625.png", "image/png") } #issues multi-part request
      name nil
    end
  end
end
