# == Schema Information
#
# Table name: records
#
#  id         :integer          not null, primary key
#  day        :date             not null
#  weight     :float(24)        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :record do
    weight { "50" }
    day { "2021-01-01" }
  end
end
