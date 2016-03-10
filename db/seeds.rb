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
  "Western",
  ]

genres.each do |genre_name|
  Genre.create(name: genre_name)
end

