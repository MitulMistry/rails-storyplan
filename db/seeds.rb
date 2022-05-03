# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

genres = [
  ["Action", "An action story is similar to adventure, and the protagonist usually takes a risky turn, which leads to desperate situations (including explosions, fight scenes, daring escapes, etc.)"],
  ["Adventure", "An adventure story is about a protagonist who journeys to epic or distant places to accomplish something."],
  ["Comedy", "Comedy is a story that tells about a series of funny or comical events, intended to make the audience laugh."],
  ["Crime", "A crime story is about a crime that is being committed or was committed. It can also be an account of a criminal's life."],
  ["Drama", "Drama is a genre of narrative fiction (or semi-fiction) intended to be more serious than humorous in tone,[2] focusing on in-depth development of realistic characters who must deal with realistic emotional struggles."],
  ["Fantasy", "A fantasy story is about magic or supernatural forces, rather than technology, though it often is made to include elements of other genres, such as science fiction elements."],
  ["Historical", "A story about a real person or event."],
  ["Historical fiction", "The genre historical fiction includes stories that are about the past."],
  ["Horror", "A horror story is told to deliberately scare or frighten the audience, through suspense, violence or shock."],
  ["Magical realism", "Magical realism, also called Magic realism, is literary works where magical events form part of ordinary life."],
  ["Mystery", "A mystery story follows an investigator as he/she attempts to solve a puzzle (often a crime)."],
  ["Paranoid", "Paranoid fiction is works of literature that explore the subjective nature of reality and how it can be manipulated by forces in power."],
  ["Philosophical", "Philosophical fiction is fiction in which a significant proportion of the work is devoted to a discussion of the sort of questions normally addressed in discursive philosophy."],
  ["Political", "Political fiction is a subgenre of fiction that deals with political affairs. Political fiction has often used narrative to provide commentary on political events, systems and theories."],
  ["Romance", "Romance novels are emotion-driven stories that are primarily focused on the relationship between the main characters of the story."],
  ["Saga", "Sagas are stories mostly about ancient Nordic and Germanic history, about early Viking voyages, the battles that took place during the voyages, about migration to Iceland and of feuds between Icelandic families."],
  ["Satire", "In satire, human or individual vices, follies, abuses, or shortcomings are held up to censure by means of ridicule, derision, burlesque, irony, or other methods, ideally with the intent to bring about improvement."],
  ["Science fiction", "Science fiction is similar to fantasy, except stories in this genre use scientific understanding to explain the universe that it takes place in."],
  ["Slice of life", "A Slice of Life is a story that might have no plot, but represents a portion of (everyday) life."],
  ["Speculative", "Speculative fiction speculates about worlds that are unlike the real world in various important ways."],
  ["Surreal", "The surreal genre is predicated on deliberate violations of causal reasoning, producing events and behaviours that are obviously illogical."],
  ["Thriller", "A Thriller is a story that is usually a mix of fear and excitement. It has traits from the suspense genre and often from the action, adventure or mystery genres, but the level of terror makes it borderline horror fiction at times as well."],
  ["Urban", "Urban fiction, also known as street lit, is a literary genre set, as the name implies, in a city landscape; however, the genre is as much defined by the race and culture of its characters as the urban setting."],
  ["Western", "Stories in the Western genre are set in the American West, between the time of the Civil war and the early nineteenth century."]
]

puts "Creating genres..."

genres.each do |genre_array|
  Genre.create(name: genre_array[0], description: genre_array[1])
end

audiences = [
  "Adult",
  "Young Adult",
  "Female",
  "Male",
  "Children"
  ]

puts "Creating audiences..."

audiences.each do |audience|
  Audience.create(name: audience)
end

puts "Creating users..."

25.times do
  user = User.new(
    username: Faker::Internet.user_name,
    full_name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "password",
    bio: Faker::Lorem.paragraph
    )
  user.avatar_from_url("http://loremflickr.com/400/400/portrait")
  user.save
end

puts "Creating stories..."

35.times do
  story = Story.new(
    name: Faker::Book.title,
    target_word_count: (Faker::Number.between(from: 1, to: 100) * 1000),
    overview: Faker::Lorem.paragraph
    )
  story.user = User.order("RANDOM()").first
  story.audiences << Audience.order("RANDOM()").first

  genre = Genre.order("RANDOM()")
  story.genres << genre.first
  story.genres << genre.second

  story.cover_from_url("http://loremflickr.com/400/625/nature,landscape,urban,abstract")
  story.save
end

puts "Creating chapters..."

50.times do
  story = Story.order("RANDOM()").first
  chapter = story.chapters.build(
    name: Faker::Book.title,
    objective: Faker::Lorem.sentence,
    target_word_count: (Faker::Number.between(from: 5, to: 80) * 100),
    overview: Faker::Lorem.paragraph
    )
  chapter.currently_writing = true if Faker::Number.between(from: 1, to: 3) == 1
  chapter.save
end

puts "Creating characters..."

50.times do
  chapter = Chapter.order("RANDOM()").first
  user = chapter.user

  # user = User.order("RANDOM()").first
  # until !user.chapters.empty?
  #   user = User.order("RANDOM()").first
  # end

  character = user.characters.build(
    name: Faker::Superhero.name,
    bio: Faker::Lorem.paragraph,
    traits: Faker::Lorem.sentence
    )
  #2.times { char.chapters << usr.chapters.order("RANDOM()").first }
  #char.chapters << usr.chapters.first
  character.chapters << user.chapters.order("RANDOM()").first
  # character.portrait_from_url("https://robohash.org/" + Faker::Crypto.md5 + "/size_400x400/set_any/bgset_any")
  character.portrait_from_url("http://loremflickr.com/400/400/portrait")
  character.save
end

puts "Creating comments..."

100.times do
  user = User.order("RANDOM()").first
  comment =  user.comments.build(content: Faker::Lorem.paragraph)
  comment.story = Story.order("RANDOM()").first
  comment.save
end

puts "Seeding complete."