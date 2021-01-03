require 'rails_helper'

RSpec.describe Parent, type: :model do
 it "is valid with a name and email and password" do
    expect(FactoryBot.create(:parent)).to be_valid
 end
 
 it "is invalid without a name" do
   # parent = Parent.new(
   #  name: nil,
   #  email: "email@example.com",
   #  password: "password1",
   #  )
   #  parent.valid?
   #  expect(parent.errors[:name]).to include("を入力してください")
   expect(FactoryBot.build(:parent, name: "")).to_not be_valid
 end
 
 it "nameが51文字以上だと登録できないか" do
   expect(FactoryBot.build(:parent, name: "a"*51)).to be_invalid
 end
 
 describe "emailのバリデーションチェック" do
   it "is invalid without a email" do
     expect(FactoryBot.build(:parent, email: "")).to be_invalid
   end
   
   it "メールアドレスが重複していたら登録できない" do
     parent = FactoryBot.create(:parent, name: "foo", email: "foo@example.com")
     expect(FactoryBot.build(:parent, name: "baz", email: parent.email)).to be_invalid
   end
   
   it "メールアドレスが256文字以上だと登録できないか" do
     expect(FactoryBot.build(:parent, email: "a"*252+"@a.a")).to be_invalid
   end
   
   it "メールアドレスの無効なフォーマットで登録できないか" do
     addresses = %w[parent@foo,com parent_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com foo@bar..com]
     addresses.each do |address|
      expect(FactoryBot.build(:parent, email: address)).to be_invalid
     end
   end
   
   it "大文字で登録された場合小文字に変換して登録できているか" do
     parent = FactoryBot.create(:parent, email: "Foo@ExAmpLe.Com")
     expect(parent.email).to eq "foo@example.com"
   end
 end
 
 describe "passwordのバリデーションチェック" do
   it "is invalid without a password" do
     expect(FactoryBot.build(:parent, password: "")).to be_invalid
   end
   
   it "パスワードが暗号化されているか" do
     parent = FactoryBot.create(:parent)
     expect(parent.password_digest).to_not eq "password1"
   end
   
   it "password_confirmationとpasswordが異なる場合保存できない" do
     expect(FactoryBot.build(:parent, password:"password1",password_confirmation: "passward1")).to be_invalid
   end
   
   it "passwordが７文字以下だと登録できないか" do
      expect(FactoryBot.build(:parent, password: "a"*7)).to be_invalid
   end
   
   it "パスワードの無効なフォーマットで登録できないか" do
     strings = %w[aaaaaaaa 11111111 aaaaaa1@ 111111a¥]
     strings.each do |string|
      expect(FactoryBot.build(:parent, password: string)).to be_invalid
     end
   end
 end
 
 describe "association" do
  describe "children" do
    before do
      @parent = FactoryBot.create(:parent)
      @icon = FactoryBot.create(:icon)
      @child1 = FactoryBot.create(:child, parent_id: @parent.id, icon_id: @icon.id)
    end
    # it "has many children"
    describe "parentが削除されるとparentに紐づくchildが削除されること" do
       context "childが1人の場合" do
         it "childモデルが1減ること" do
           expect{ @parent.destroy }.to change{ Child.count }.by(-1)
         end
       end
       context "childが2人の場合" do
         it "childモデルが2減ること" do
           child2 = FactoryBot.create(:child, parent_id: @parent.id, icon_id: @icon.id)
           expect{ @parent.destroy }.to change{ Child.count }.by(-2)
         end
       end
     end
   end
    
    
  end
end
