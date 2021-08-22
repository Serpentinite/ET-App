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
require 'rails_helper'

RSpec.describe Record, type: :model do
  describe "commentのテスト" do
    before do
      @record = FactoryBot.build(:record)
      @user = FactoryBot.create(:user,name: "test", email: "test_record@example.com", password: "password")
    end
    context "全てのデータが入っている場合" do
      it "全て入力してあるので保存" do
        @record.user_id = @user.id
        expect(@record.save).to be true
      end
    end
    context "全てのデータが入っていない場合" do
      it "全て入力してないので保存されない" do
        @record.user_id = @user.id
        @record.weight = ""
        @record.day = ""
        expect(@record.save).to be false
      end      
    end
  end
  describe "バリデーションのテスト" do
    before do
      @record = FactoryBot.build(:record)
    end
    it "体重が0以上であること" do
      @record.weight = -160
      @record.valid?
      expect(@record.errors[:weight]).to include("は0以上の値にしてください")
    end
  end
end
