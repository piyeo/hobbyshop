Category.create(name: "ゲームソフト")

10.times do |n|
  category_id = 1
  name  = Faker::Name.name
  body = Faker::Lorem.paragraphs
  stock = 100
  price = 5000
  release = Date.today
  Item.create(category_id: category_id,name: name,body: body,stock: stock,price: price,release: release)
end
