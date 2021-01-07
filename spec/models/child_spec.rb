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
   
  # it "大文字で登録された場合小文字に変換して登録できているか" do
  #   child = FactoryBot.create(:child, login_id: "FooExAmpLe")
  #   expect(child.login_id).to eq "fooexample"
  # end
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
   
   it "password_confirmationとpasswordが異なる場合保存できない" do
     expect(FactoryBot.build(:child, password:"password1",password_confirmation: "passward1")).to be_invalid
   end
   
   it "passwordが７文字以下だと登録できないか" do
      expect(FactoryBot.build(:child, password: "a"*7)).to be_invalid
   end
   
   it "パスワードの無効なフォーマットで登録できないか" do
     strings = %w[aaaaaaaa 11111111 aaaaaa1@ 111111a¥]
     strings.each do |string|
      expect(FactoryBot.build(:child, password: string)).to be_invalid
     end
   end
 end
 
 describe "association" do
  describe "helps" do
    before do
      # @parent = FactoryBot.create(:parent)
      # @icon = FactoryBot.create(:icon)
      @child = FactoryBot.create(:child)
      @help = FactoryBot.create(:help, child_id: @child.id)
    end
    describe "childが削除されるとchildに紐づくhelpが削除されること" do
       context "helpが1つの場合" do
         it "helpモデルが1減ること" do
           expect{ @child.destroy }.to change{ Help.count }.by(-1)
         end
       end
       context "helpが2つの場合" do
         it "helpモデルが2減ること" do
           help2 = FactoryBot.create(:help, child_id: @child.id)
           expect{ @child.destroy }.to change{ Help.count }.by(-2)
         end
       end
     end
   end
   
   describe "requests" do
     before do
       @child = FactoryBot.create(:child)
       @request = FactoryBot.create(:request, child_id: @child.id)
     end
     describe "childが削除されるとchildに紐づくrequestが削除されること" do
       context "requestが1つの場合" do
         it "requestモデルが1減ること" do
           expect{ @child.destroy }.to change{ Request.count }.by(-1)
         end
       end
       context "requestが2つの場合" do
         it "requestモデルが2減ること" do
           request2 = FactoryBot.create(:request, child_id: @child.id)
           expect{ @child.destroy }.to change{ Request.count }.by(-2)
         end
       end
     end
   end
   
   describe "applies" do
     describe "childが削除されるとrequestsを通してapplyが削除される" do
       before do
         @child = FactoryBot.create(:child)
         @request = FactoryBot.create(:request, child_id: @child.id)
         @apply = FactoryBot.create(:apply, request_id: @request.id)
       end
       context "applyが１つの場合" do
         it "applyモデルが1減ること" do
           
         end
       end
     end
   end
   
 end
 
end
