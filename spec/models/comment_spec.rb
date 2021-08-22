# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  comment    :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :integer
#  user_id    :integer
#
# Foreign Keys
#
#  fk_rails_...  (board_id => boards.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "commentのテスト" do
    before do
      @comment = FactoryBot.build(:comment)
      @board = FactoryBot.create(:board)
      @user = FactoryBot.create(:user,name: "test", email: "test_comment@example.com", password: "password")
    end

    context "全てのデータが入っている場合" do
      it "全て入力してあるので保存" do
        @comment.board_id = @board.id
        @comment.user_id = @user.id
        expect(@comment.save).to be true
      end
    end
    context "全てのデータが入っていない場合" do
      it "全て入力してないので保存されない" do
        @comment.board_id = @board.id
        @comment.user_id = @user.id
        @comment.comment = ""
        expect(@comment.save).to be false
      end      
    end
  end
  describe "バリデーションのテスト" do
    before do
      @comment = FactoryBot.build(:comment)
    end
    context "無効な状態" do
      it "コメントが存在しないこと" do
        @comment.comment = ""
        @comment.valid?
        expect(@comment.errors[:comment]).to include("を入力してください")
      end
    end
    context "字数を超える場合" do
      it "コメントのエラーメッセージが出ること" do
        @comment.comment = "a" * 1001
        @comment.valid?
        expect(@comment.errors[:comment]).to include("は1000文字以内で入力してください")
      end
    end
  end
end
