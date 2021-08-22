# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  height                 :float(24)
#  name                   :string(255)      not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end


  describe "バリデーションのテスト" do
    it "名前、メール、身長があれば有効であること" do
      expect(@user).to be_valid
    end

    it "身長が0以上であること" do
      @user.height = -160
      @user.valid?
      expect(@user.errors[:height]).to include("は0以上の値にしてください")
    end
    it "名前がなければ無効な状態であること" do
      @user.name = ""
      @user.valid?
      expect(@user.errors[:name]).to include("を入力してください")
    end

    it "名前が30文字以下でなければ無効であること" do
      @user.name = "a" * 31
      @user.valid?
      expect(@user.errors[:name]).to include("は30文字以内で入力してください")
    end
    it "メールアドレスがなければ無効な状態であること" do
      @user.email = ""
      @user.valid?
      expect(@user.errors[:email]).to include("を入力してください")
    end
    it "メールアドレスが30文字以下でなければ無効な状態であること" do
      @user.email = "a" * 31
      @user.valid?
      expect(@user.errors[:email]).to include("は不正な値です"), ("は30文字以下で入力してください")
    end
    it "パスワードが6文字以上でなければ無効であること" do
      @user.password = "a" * 5
      @user.valid?
      expect(@user.errors[:password]).to include("は6文字以上で入力してください")
    end
    it "重複したメールアドレスなら無効な状態であること" do
      FactoryBot.create(:user)
      @user.valid?
      expect(@user.errors[:email]).to include("はすでに存在します")
    end
  end

end
