# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cat.create!(
  name: "Sherlock", color: "black",
  birth_date: "2012-2-15", sex: "M",
  description: "Sherlock is very intelligent, he's often seen in the corner" +
    "smoking his pipe and playing the violin. Also an expert martial artist."
)

Cat.create!(
  name: "Huxley", color: "white",
  birth_date: '1991-06-01', sex: "M",
  description: "A one-eyed cat famous for appearing in the bedrooms of" +
    " several neighbors"
)

Cat.create!(
  name: "Caesar", color: "orange",
  birth_date: '1980-03-15', sex: "M",
  description: "Quick tempered and listens to no one, he likes to" +
  " roam the neighborhood and bully French bulldogs."
)

Cat.create!(
  name: 'Bubbles', color: "fuschia",
  birth_date: '2005-09-12', sex: "F",
  description: "What a pathetic cat."
)