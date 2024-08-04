# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
%w[kitchen laundry lavatory].each do |cat|
  Category.create(name: cat)
end

%w[pulses flour].each do |scat|
  cat = Category.find_by(name: 'kitchen')
  SubCategory.create(name: scat, category_id: cat.id)
end

['detergent', 'washing soap'].each do |scat|
  cat = Category.find_by(name: 'laundry')
  SubCategory.create(name: scat, category_id: cat.id)
end

['Shampoo', 'bathing soap', 'cleaner'].each do |scat|
  cat = Category.find_by(name: 'lavatory')
  SubCategory.create(name: scat, category_id: cat.id)
end
