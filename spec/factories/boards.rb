FactoryBot.define do
  factory :board do
    body { "テスト本文" }
    title { "テストタイトル" }
    user
  end
end
