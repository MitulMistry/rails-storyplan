FactoryBot.define do
  factory :user do
    username { Faker::Internet.user_name(separators: %w(_ -)) }
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8, max_length: 20) }
    bio { Faker::Lorem.paragraph }

    factory :invalid_user do
      full_name { Faker::Lorem.characters(number: 201) }
    end

    factory :user_with_avatar do # use test file for attached Active Storage image
      avatar { fixture_file_upload(Rails.root.join("spec", "support", "assets", "test_user_avatar_400.png"), "image/png") }
    end

    factory :user_with_uploaded_avatar do # use this child factory when making a post/patch request with attributes_for
      avatar { fixture_file_upload(Rails.root.join("spec", "support", "assets", "test_user_avatar_400.png"), "image/png") }
    end

    factory :invalid_user_with_uploaded_avatar do # use this child factory when making a post/patch request with attributes_for
      avatar { fixture_file_upload(Rails.root.join("spec", "support", "assets", "test_user_avatar_400.png"), "image/png") }
      name { nil }
    end
  end
end
