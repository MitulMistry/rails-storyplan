# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

genres = [
  "Surreal",
  "Action",
  "Adventure",
  "Comedy",
  "Crime",
  "Drama",
  "Erotica",
  "Fantasy",
  "Historical",
  "Historical fiction",
  "Horror",
  "Magical realism",
  "Mystery",
  "Paranoid",
  "Philosophical",
  "Political",
  "Romance",
  "Saga",
  "Satire",
  "Science fiction",
  "Slice of life",
  "Speculative",
  "Thriller",
  "Urban",
  "Western"
  ]

genres.each do |genre_name|
  Genre.create(name: genre_name)
end

user1 = User.create(username: "bjones", full_name: "Bob Jones", email: "user1@example.com", password: "password")
user2 = User.create(username: "sylvestrin", full_name: "Sarah Parker", email: "user2@example.com", password: "password")

story1 = Story.new(name: Faker::Book.title, target_word_count: (Faker::Number.between(1, 100) * 100), target_audience: "Adult", overview: Faker::Lorem.paragraph)
story1.user = user1
story1.save

story2 = Story.new(name: Faker::Book.title, target_word_count: (Faker::Number.between(1, 100) * 100), target_audience: "Adult", overview: Faker::Lorem.paragraph)
story2.user = user1
story2.save

story3 = Story.new(name: Faker::Book.title, target_word_count: (Faker::Number.between(1, 100) * 100), target_audience: "Young Adult", overview: Faker::Lorem.paragraph)
story3.user = user2
story3.save

story4 = Story.new(name: Faker::Book.title, target_word_count: (Faker::Number.between(1, 100) * 100), target_audience: "Young Adult", overview: Faker::Lorem.paragraph)
story4.user = user2
story4.save

