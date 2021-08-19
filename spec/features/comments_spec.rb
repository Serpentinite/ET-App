require 'rails_helper'

RSpec.feature "Comments", type: :feature do
  let!(:user){FactoryBot.create(:user,name: "test", email: "test_comment@example.com", password: "password")}
  let(:board){FactoryBot.create(:board)}
  let(:comment){FactoryBot.create(:comment, user:user, board:board)}
  before do
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button 'ログイン'
  end
  describe 'コメントのテスト' do
    before do
      visit board_path(board)
    end
    it 'コメントのフォームが表示される' do
      expect(page).to have_field 'コメント記入'
    end
    it 'コメント記入の成功' do
      fill_in "コメント記入", with: comment.comment
      click_button '送信'
      expect(page).to have_content "コメントを投稿しました"
    end
    it 'コメント記入の失敗' do
      fill_in "コメント記入", with: ""
      click_button '送信'
      expect(page).to have_content "コメントを入力してください"
    end
  end
end
