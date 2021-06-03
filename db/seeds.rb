# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'admin@email.com',
  password: 'password'
)

puts 'admin created!'
# ActiveStorage::AnalyzeJob.queue_adapter = :inline
# ActiveStorage::PurgeJob.queue_adapter = :inline

10.times do |n|
  Category.create!(
    name: "sample category#{n + 1}"
  )
end

puts 'sample category created!'

10.times do |n|
  Brand.create!(
    name: "sample brand#{n +1}"
  )
end

puts 'sample brand created!'

20.times do |n|
  product = Product.create(
              model: "#{rand(340..570)}XP",
              category_id: rand(Category.find(1).id..Category.find(10).id),
              brand_id: rand(Brand.find(1).id..Brand.find(10).id),
            )
  product.document.attach(io: File.open("public/test_seed.pdf"), filename: "test_seed.pdf", content_type: "application/pdf")
  product.save
end

puts 'sample product created!'
