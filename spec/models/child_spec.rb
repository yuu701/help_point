require 'rails_helper'

RSpec.describe Child, type: :model do
  it "is valid with a name and login_id and password" do
    expect(FactoryBot.create(:parent)).to be_valid
 end
 
 it "is invalid without a name" do
   expect(FactoryBot.build(:parent, name: "")).to_not be_valid
 end
 
 it "is invalid without a email" do
   expect(FactoryBot.build(:parent, email: "")).to_not be_valid
 end
 
 it "メールアドレスが重複していたら登録できない" do
   parent1 = FactoryBot.create(:parent, name: "taro", email: "taro@example.com")
   expect(FactoryBot.build(:parent, name: "ziro", email: parent1.email)).to_not be_valid
 end
 
 it "is invalid without a password" do
   expect(FactoryBot.build(:parent, password: "")).to_not be_valid
 end
 
 it "パスワードが暗号化されているか" do
   parent = FactoryBot.create(:parent)
   expect(parent.password_digest).to_not eq "password1"
 end
 
 it "password_confirmationとpasswordが異なる場合保存できない" do
   expect(FactoryBot.build(:parent, password:"password1",password_confirmation: "passward1")).to_not be_valid
 end
end
