User.create(name: "田中太郎", nickname: "Taro", sex: 1,phone: "09012345678",
  email: "example@gmail.com",birthday: "1999-12-17",postcode:"123-4567",
  address: "神奈川県茅ヶ崎市香川2丁目6番地", password: "foobar", password_confirmation: "foobar"
)

Category.create(name: "ゲームソフト")

50.times do |n|
  category_id = 1
  name  = Faker::Game.title
  body = Faker::Lorem.paragraphs
  stock = 100
  price = 5000
  release = Date.today
  Item.create(category_id: category_id,name: name,body: body,stock: stock,price: price,release: release)
end
