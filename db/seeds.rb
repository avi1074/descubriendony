# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Category.all.each do |category|
#   category.update_attributes(:city=>"newyorkcity")
# end

Line.all.each do |line|
  line.update_attributes(:city=>"newyorkcity")
end

Line.create(name: "Blue Line", short_name: "Blue Line", color: "0073cf", city: "losangeles")
Line.create(name: "Expo Line", short_name: "Expo Line", color: "10c4ff", city: "losangeles")
Line.create(name: "Gold Line", short_name: "Gold Line", color: "f0ab00", city: "losangeles")
Line.create(name: "Green Line", short_name: "Green Line", color: "61c250", city: "losangeles")
Line.create(name: "Purple Line", short_name: "Purple Line", color: "b634bb", city: "losangeles")
Line.create(name: "Red Line", short_name: "Red Line", color: "ef3e42", city: "losangeles")
