# == Schema Information
#
# Table name: boards
#
#  id         :integer          not null, primary key
#  body       :text(65535)
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Board < ApplicationRecord
    has_many :comments, dependent: :destroy
    has_many :board_tag_relations, dependent: :destroy
    has_many :tags, through: :board_tag_relations
    belongs_to :user
    validates :title, presence: true, length: { maximum: 30 }
    validates :body, presence: true, length: { maximum: 1000 }

    def self.bool(params_tag, params_search)
        if params_tag.present?
            @boards = Tag.find(params_tag).boards
        elsif params_search.present?
            @board = Board.where(['title Like ?', "%#{params_search}%"])
        else
            Board.all
        end
    end
end
