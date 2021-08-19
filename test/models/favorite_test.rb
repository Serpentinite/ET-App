# == Schema Information
#
# Table name: favorites
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  comment_id :integer
#  user_id    :integer
#
# Foreign Keys
#
#  fk_rails_...  (comment_id => comments.id)
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
