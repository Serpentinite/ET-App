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
class Record < ApplicationRecord
  belongs_to :user

  validates :weight, numericality: { greater_than_or_equal_to: 0}
end
