FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name(nil, %w(_ -)) }
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(8, 20) }
    bio { Faker::Lorem.paragraph }

    factory :invalid_user do
      full_name { Faker::Lorem.characters(201) }
    end

    factory :user_with_avatar do #use test file for attached Paperclip image
      avatar { File.new("#{Rails.root}/spec/support/fixtures/images/test_user_avatar_400.png") }
    end

    factory :user_with_uploaded_avatar do #use this child factory when making a post/patch request with attributes_for
      avatar { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/fixtures/images/test_user_avatar_400.png", "image/png") } #issues multi-part request
    end

    factory :invalid_user_with_uploaded_avatar do #use this child factory when making a post/patch request with attributes_for
      avatar { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/fixtures/images/test_user_avatar_400.png", "image/png") } #issues multi-part request
      name nil
    end
  end
end
