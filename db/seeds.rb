# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Division.destroy_all

10.times do |index|
  Division.create!(name: Faker::Movies::BackToTheFuture.character)
end

divs = Division.all.map { |d| d.id };

Employee.destroy_all

50.times do |index|
  Employee.create!(name: Faker::Movies::BackToTheFuture.character,
    division_id: divs[rand(divs.length)])
end

p "Created #{Division.count} divisions"
p "Created #{Employee.count} employees"
