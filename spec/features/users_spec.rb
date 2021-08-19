require 'rails_helper'

RSpec.feature "User", type: :feature do
  let(:user){FactoryBot.create(:user)}
  describe 'ユーザ認証のテスト' do
    describe 'ユーザ新規登録' do
      before do
        visit new_user_registration_path
      end
      context '新規画面に遷移' do
        it '新規登録に成功する' do
          fill_in '名前', with: "ヤマダテスト"
          fill_in '身長', with: 160
          fill_in 'メールアドレス', with: "test@example.com"
          fill_in 'パスワード', with: "testyamada"
          fill_in 'パスワード確認', with: "testyamada"
          click_button '登録する'
          expect(page).to have_content 'アカウント登録が完了しました。'
        end
        it '新規登録に失敗する' do
          fill_in '名前', with: ""
          fill_in '身長', with: ""
          fill_in 'メールアドレス', with: ""
          fill_in 'パスワード', with: ""
          fill_in 'パスワード確認', with: ""
          click_button '登録する'
          expect(page).to have_content '4 件のエラーが発生したため ユーザ は保存されませんでした。'
        end
      end
    end

    describe 'ユーザログイン' do
      before do
        visit new_user_session_path
      end
      context 'ログイン画面に遷移' do
        it 'ログインに成功する' do
          fill_in "メールアドレス", with: user.email
          fill_in "パスワード", with: user.password
          click_button 'ログイン'
          expect(page).to have_content 'ログインしました。'
          expect(current_path).to eq root_path
        end
        it 'ログインに失敗する' do
          fill_in "メールアドレス", with: ""
          fill_in "パスワード", with: ""
          click_button 'ログイン'
          expect(current_path).to eq new_user_session_path
        end
      end
    end

    describe 'ユーザのテスト' do
      before do
        visit new_user_session_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: user.password
        click_button 'ログイン'
      end
      describe 'マイページのテスト' do
        it 'ログイン後のナビゲーション' do
          expect(page).to have_content('マイページ')
          expect(page).to have_content('体重管理')
          expect(page).to have_content('ログアウト')
        end
        it 'マイページの表示' do
          visit user_path(user)
          expect(page).to have_content('アカウント編集')
        end
        it '体重が未入力のマイページ' do
          visit user_path(user)
          expect(page).not_to have_content('BMI')
        end
      end
      describe '編集のテスト' do
        context '編集画面へ遷移' do
          it '遷移ができる' do
            visit edit_user_registration_path
            expect(current_path).to eq edit_user_registration_path
          end
        end
        context '表示の確認と編集' do
          before do
            visit edit_user_registration_path
          end
          it '編集と表示される' do
            expect(page).to have_content('編集')
          end
          it '名前編集フォームに自分の名前が表示される' do
            expect(page).to have_field '名前', with: user.name
          end
          it 'メールアドレス編集フォームに自分のメールアドレスが表示される' do
            expect(page).to have_field 'メールアドレス', with: user.email
          end
          it '身長編集フォームに自分の身長が表示される' do
            expect(page).to have_field '身長', with: user.height
          end
          it '編集に成功する' do
            fill_in '名前', with: 'タナカテスト'
            click_button '更新'
            expect(page).to have_content 'アカウント情報を変更しました。'
            expect(page).to have_content 'タナカテスト'
            expect(current_path).to eq user_path(user)
          end
          it '編集に失敗する' do
            fill_in '名前', with: ''
            click_button '更新'
            expect(page).to have_content '1 件のエラーが発生したため ユーザ は保存されませんでした。'
            expect(current_path).to eq ('/users')
          end
        end
      end
    end
  end
end
