# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Cleaning old seeds...'
Character::Class.destroy_all
Character::Template.destroy_all
Character::Nature.destroy_all
puts 'Cleaning old seeds... Done'

Dir[File.join(Rails.root, 'db', 'seeds/', '*.rb')].sort.each do |seed|
  puts "Seeding #{seed}..."
  load seed
  puts '...done'
end

Dir[File.join(Rails.root, 'db', 'seeds/dependant', '*.rb')].sort.each do |seed|
  puts "Seeding #{seed}..."
	load seed
  puts '...done'
end