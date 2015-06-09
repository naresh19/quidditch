# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
u = User.create(email: "super_user@gmail.com",password: "12345678")

t1 = Team.create(name: "Mumbai")

7.times do |i|
  name = (0...8).map { (65 + rand(26)).chr }.join
  Player.create(name:  name,age: rand(10..30),team_id: t1.id)
end
t2 = Team.create(name: "Delhi")
7.times do |i|
  name = (0...8).map { (65 + rand(26)).chr }.join
  Player.create(name:  name,age: rand(10..30),team_id: t2.id)
end
t3 = Team.create(name: "Chennai")
7.times do |i|
  name = (0...8).map { (65 + rand(26)).chr }.join
  Player.create(name:  name,age: rand(10..30),team_id: t3.id)
end

match1  = Match.create(team1_id: t1.id,team2_id: t2.id)

match1 = Match.create(team1_id: t1.id,team2_id: t3.id)