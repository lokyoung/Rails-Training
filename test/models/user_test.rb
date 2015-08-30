require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "lcy", email: "252013495@qq.com",
                     password: "123456", password_confirmation: "123456")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should not be empty" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "email should not be empty" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 256
    assert_not @user.valid?
  end

  test "email format" do
    valid_addresses = %w[user@example.com A_US-ER@foo.bar.org
                             first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      # 如果测试错误，则执行第二个参数
      assert @user.valid?, "#{address.inspect} should be vaild"
    end
  end

  test "email should be unique" do
    # dup方法创建一个和调用者（此处为@user）一样的对象
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
