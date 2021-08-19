require 'rails_helper'

RSpec.feature "Records", type: :feature do
  let!(:user){FactoryBot.create(:user,name: "test", email: "test_board@example.com", password: "password")}
  let(:record){FactoryBot.create(:record, user:user)}
  before do
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button 'ログイン'
  end
  describe 'レコードのテスト' do
    before do
      visit records_path
    end
    it 'レコードに体重のフォームが表示される' do
      expect(page).to have_field '体重入力'
    end
    it '体重の記入の成功' do
      fill_in "体重入力", with: record.weight
      click_button '保存'
      expect(page).to have_content "入力しました"
    end
    it '体重の記入の失敗' do
      fill_in "体重入力", with: ""
      click_button '保存'
      expect(page).to have_content "体重は数値で入力してください"
    end
  end
end
