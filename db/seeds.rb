# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do |n|
    User.create!(
      email: "test#{n + 1}@test.com",
      name: "ユーザー#{n + 1}",
      password: "123456",
    )
end

Tag.create!(
  name: "Java"
)
Tag.create!(
  name: "C言語"
)
Tag.create!(
  name: "C++"
)
Tag.create!(
  name: "C＃"
)
Tag.create!(
  name: "Objective-C"
)
Tag.create!(
  name: "Visual Basic"
)
Tag.create!(
  name: "Python"
)
Tag.create!(
  name: "Ruby"
)
Tag.create!(
  name: "JavaScript"
)
Tag.create!(
  name: "PHP"
)
Tag.create!(
  name: "Swift"
)
Tag.create!(
  name: "コーヒー"
)
Tag.create!(
  name: "ケーキ"
)
Tag.create!(
  name: "犬"
)
Tag.create!(
  name: "猫"
)
Tag.create!(
  name: "リス"
)
Tag.create!(
  name: "ペット"
)
Tag.create!(
  name: "日本"
)
Tag.create!(
  name: "アメリカ"
)
Tag.create!(
  name: "フランス"
)
Tag.create!(
  name: "カナダ"
)
Tag.create!(
  name: "旅行"
)
Tag.create!(
  name: "カメラ"
)
