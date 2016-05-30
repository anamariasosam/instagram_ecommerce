# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.destroy_all
puts 'destroying data...'
for i in 0..9
  puts "Creating product #{i}"
  product = Product.create(
      instagram_image: 'http://lorempixel.com/400/400',
      price: rand(1000..1000000),
      user_id: 1,
      quantity: 2,
      description: 'Lorem ipsum dolor sit amet doloribus, minus repellat quo optio asperiores ullam aliquam.',
      product_name: "Camisa #{i}"
    )
end
