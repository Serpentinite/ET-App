# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env == 'production'
    Tag.create([
        { name: '筋トレ' },
        { name: 'ダイエット' },
        { name: 'プロテイン' },
        { name: '減量' },
        { name: '増量' },
        { name: '食事' },
        { name: '有酸素運動' },
        { name: 'その他'}
    ])
end