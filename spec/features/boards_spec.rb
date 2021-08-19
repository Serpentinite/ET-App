require 'rails_helper'

RSpec.feature "Boards", type: :feature do
  let!(:user){FactoryBot.create(:user,name: "test", email: "test_board@example.com", password: "password")}
  let(:board){FactoryBot.create(:board, user:user)}
  before do
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button 'ログイン'
  end
  describe '投稿のテスト' do
    context '新規掲示板ページへの遷移' do
      before do
        visit boards_path
      end
      it '一覧ページの表示の確認' do
        expect(page).to have_content "質問スレッド一覧"
      end
      it '遷移する' do
        click_link '新規作成'
        expect(page).to have_content "質問スレッドの作成"
        expect(current_path).to eq new_board_path
      end
    end
    context '新規作成画面の表示の確認' do
      before do
        visit new_board_path
      end
      it 'タイトルのフォームが表示される' do
        expect(page).to have_field 'タイトル'
      end
      it '本文のフォームが表示される' do
        expect(page).to have_field '本文'
      end
    end
    context '質問の投稿' do
      before do
        visit new_board_path
      end
      it '投稿に成功する' do
        fill_in "タイトル", with: board.title
        fill_in "本文", with: board.body
        click_button '保存'
        expect(page).to have_content "が作成されました"
      end
      it '投稿に失敗する' do
        fill_in 'タイトル', with: ""
        fill_in '本文', with: ""
        click_button '保存'
        expect(page).to have_content "タイトルを入力してください"
        expect(page).to have_content "本文を入力してください"
      end
    end
  end
  describe '詳細画面のテスト' do
    context '詳細画面からの遷移の確認' do
      before do
        visit new_board_path
        fill_in "タイトル", with: board.title
        fill_in "本文", with: board.body
        click_button '保存'
        visit board_path(board)
      end
      it '一覧画面への遷移' do
        expect(page).to have_content "一覧"
        click_on "一覧"
        expect(current_path).to eq boards_path
      end
    end
    context '編集画面のテスト' do
      before do
        visit board_path(board)
      end
      it '編集画面への遷移' do
        expect(page).to have_content "編集"
        click_on "編集"
        expect(current_path).to eq edit_board_path(board)
      end
      it '質問の編集の成功' do
        visit edit_board_path(board)
        fill_in "タイトル", with: board.title
        fill_in "本文", with: board.body
        click_button '保存'
        expect(page).to have_content "の編集が完了しました"
      end
      it '質問の編集の失敗' do
        visit edit_board_path(board)
        fill_in 'タイトル', with: ""
        fill_in '本文', with: ""
        click_button '保存'
        expect(page).to have_content "タイトルを入力してください"
        expect(page).to have_content "本文を入力してください"
      end
    end
  end
end
