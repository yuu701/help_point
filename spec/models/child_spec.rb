require 'rails_helper'

RSpec.describe Child, type: :model do
  it "is valid with a name and login_id and password and icon_id and parent_id" do
    expect(FactoryBot.create(:child)).to be_valid
 end
 
 it "is invalid without a name" do
   expect(FactoryBot.build(:child, name: "")).to_not be_valid
 end
 
 describe "login_idについてのバリデーションチェック" do
   it "is invalid without a login_id" do
     expect(FactoryBot.build(:child, login_id: "")).to_not be_valid
   end
   
   
   it "login_idが重複していたら登録できない" do
     child1 = FactoryBot.create(:child, name: "taro", login_id: "aaa")
     expect(FactoryBot.build(:child, name: "ziro", login_id: child1.login_id)).to_not be_valid
   end
 end
 
 describe "passwordについてのバリデーション チェック" do
   it "is invalid without a password" do
     expect(FactoryBot.build(:child, password: "")).to_not be_valid
   end
   
   it "パスワードが暗号化されているか" do
     child = FactoryBot.create(:child)
     expect(child.password_digest).to_not eq "password1"
   end
   
   it "password_confirmationとpasswordが異なる場合保存できない" do
     expect(FactoryBot.build(:child, password:"password1",password_confirmation: "passward1")).to_not be_valid
   end
 end
end
