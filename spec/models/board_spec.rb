require 'rails_helper'

RSpec.describe Board, type: :model do
  describe "boardのテスト" do
    before do
      @board = FactoryBot.build(:board)
      @user = FactoryBot.create(:user,name: "test", email: "test_board@example.com", password: "password")
    end

    context "全てのデータが入っている場合" do
      it "全て入力してあるので保存" do
        @board.user_id = @user.id
        expect(@board.save).to be true
      end
    end
    context "全てのデータが入っていない場合" do
      it "全て入力してないので保存されない" do
        @board.user_id = @user.id
        @board.title = ""
        @board.body = ""
        expect(@board.save).to be false
      end
    end
  end
  describe "バリデーションのテスト" do
    before do
      @board = FactoryBot.build(:board)
    end
    context "無効な状態" do
      it "タイトルが存在しないこと" do
        @board.title = ""
        @board.valid?
        expect(@board.errors[:title]).to include("を入力してください")
      end
      it "本文が存在しないこと" do
        @board.body = ""
        @board.valid?
        expect(@board.errors[:body]).to include("を入力してください")
      end
    end
    context "字数を超える場合" do
      it "タイトルのエラーメッセージが出ること" do
        @board.title = "a" * 31
        @board.valid?
        expect(@board.errors[:title]).to include("は30文字以内で入力してください")
      end
      it "本文のエラーメッセージが出ること" do
        @board.body = "a" * 1001
        @board.valid?
        expect(@board.errors[:body]).to include("は1000文字以内で入力してください")
      end
    end
  end

end
