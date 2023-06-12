# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

5.times do
  factory = Factory.create(title: Faker::Company.name, country: Faker::Address.country)
  5.times do
    factory.cars.create(manufacture: Faker::Vehicle.manufacture)
  end
  5.times do
    factory.planes.create(manufacture: Faker::Vehicle.manufacture)
  end
end
