FactoryBot.define do
  factory :comment do
    comment { "テストコメント" }
    board
    user
  end
end
