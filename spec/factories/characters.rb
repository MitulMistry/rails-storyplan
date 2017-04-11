FactoryGirl.define do
  factory :character do
    name { Faker::Superhero.name }
    bio { Faker::Lorem.paragraph }
    traits { Faker::Lorem.sentence }
    association :user

    factory :invalid_character do
      name nil
    end

    factory :character_with_portrait do #use test file for attached Paperclip image
      portrait { File.new("#{Rails.root}/spec/support/fixtures/images/test_character_portrait_400.png") }
    end

    factory :character_with_uploaded_portrait do #use this child factory when making a post/patch request with attributes_for
      portrait { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/fixtures/images/test_character_portrait_400.png", "image/png") } #issues multi-part request
    end

    factory :character_with_uploaded_wrong_portrait do #image with wrong dimensions - use this child factory when making a post/patch request with attributes_for
      portrait { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/fixtures/images/test_story_cover_400x625.png", "image/png") } #issues multi-part request
    end

    factory :invalid_character_with_uploaded_portrait do #use this child factory when making a post/patch request with attributes_for
      portrait { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/fixtures/images/test_character_portrait_400.png", "image/png") } #issues multi-part request
      name nil
    end
  end
end
