# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ActiveRecord::Base.transaction do
  
  User.create(first_name: "Muffin",		last_name: "Kitty")
  User.create(first_name: "Biscuit",	last_name: "Kitty")
  User.create(first_name: "Space",		last_name: "Cowboy")
  User.create(first_name: "Test",			last_name: "Testerson")
  User.create(first_name: "Thomas",		last_name: "Edison")
  User.create(first_name: "Jay",			last_name: "Gatsby")
  User.create(first_name: "Daisy",		last_name: "Buchanan")
  User.create(first_name: "Nick",			last_name: "Carraway")
  User.create(first_name: "Tom",			last_name: "Buchanan")
  User.create(first_name: "Jordan", 	last_name: "Baker")
  
end