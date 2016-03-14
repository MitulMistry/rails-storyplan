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

8.times do
  User.create(
    username: Faker::Internet.user_name,
    full_name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "password",
    bio: Faker::Lorem.paragraph
    )
end

12.times do
  st = Story.new(
    name: Faker::Book.title,
    target_word_count: (Faker::Number.between(1, 100) * 1000),
    target_audience: "Adult",
    overview: Faker::Lorem.paragraph,
    user_id: (Faker::Number.between(0, User.all.count - 1))
    )
  2.times { st.genres << Genre.order("RANDOM()").first }
  st.save
end

20.times do
  ch = Chapter.new(
    name: Faker::Book.title,
    objective: Faker::Lorem.sentence,
    target_word_count: (Faker::Number.between(1, 100) * 200),
    overview: Faker::Lorem.paragraph
    )
  ch.story = Story.order("RANDOM()").first
  ch.save
end

20.times do
  #usr = User.order("RANDOM()").first
  #until usr.chapters
    #usr = User.order("RANDOM()").first
  #end
  char = Character.new(
    name: Faker::Superhero.name,
    bio: Faker::Lorem.paragraph,
    traits: Faker::Lorem.sentence
    )
  #2.times { char.chapters << usr.chapters.order("RANDOM()").first }
  #char.chapters << usr.chapters.first
  char.chapters << Chapter.order("RANDOM()").first
  char.save
end


=begin
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
=end
