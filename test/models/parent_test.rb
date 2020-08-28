require 'test_helper'

class ParentTest < ActiveSupport::TestCase
  
  # テストが走る前に、インスタンス変数の @user を宣言
  def setup
    @parent = Parent.new(name: "Example Parent", email: "parent@example.com",
    password: "foobar11", password_confirmation: "foobar11")
  end

  # パリデーションを実行して、モデルが正しい値かどうかを調べる。
  test "should be valid" do
    assert @parent.valid?
  end
  
  # nameに空白が入ってしまうとエラーになるテスト
  test "name should be present" do
    @parent.name = "     "
    assert_not @parent.valid?
  end
  
  # eamilに空白が入ってしまうとエラーになるテスト
  test "email should be present" do
    @parent.email = "     "
    assert_not @parent.valid?
  end
  
  # nameが51文字だとエラーになるテスト
  test "name should not be too long" do
    @parent.name = "a" * 51
    assert_not @parent.valid?
  end

  # emailが256文字だとエラーになるテスト
  test "email should not be too long" do
    @parent.email = "a" * 244 + "@example.com"
    assert_not @parent.valid?
  end
  
  # 有効にしたいアドレスが通るかのテスト
  test "email validation should accept valid addresses" do
    valid_addresses = %w[parent@example.com PARENT@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @parent.email = valid_address
      assert @parent.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  # 無効にしたいアドレスを弾けるかのテスト
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[parent@example,com parent_at_foo.org parent.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @parent.email = invalid_address
      assert_not @parent.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  # 大文字・小文字を区別せずに重複したアドレスを弾けるかのテスト
  test "email addresses should be unique" do
    duplicate_parent = @parent.dup
    duplicate_parent.email = @parent.email.upcase
    @parent.save
    assert_not duplicate_parent.valid?
  end
  
   # メールアドレスを小文字にするテスト
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @parent.email = mixed_case_email
    @parent.save
    assert_equal mixed_case_email.downcase, @parent.reload.email
  end
  
  # パスワードがスペース8つ分の時弾かれるテスト
  test "password should be present (nonblank)" do
    @parent.password = @parent.password_confirmation = " " * 8
    assert_not @parent.valid?
  end

  # パスワードが7文字の時弾かれるテスト
  test "password should have a minimum length" do
    @parent.password = @parent.password_confirmation = "a" * 7
    assert_not @parent.valid?
  end
end
