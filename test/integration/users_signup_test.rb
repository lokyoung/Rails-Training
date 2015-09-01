require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "",
                               email: "invalid@qq.com",
                               password: "123",
                               password_confirmation: "321" }
    end
    assert_template 'users/new'
  end

  test "valid signup" do
    get signup_path
    assert_difference 'User.count', 1 do
      # 提交后继续跟踪重定向
      post_via_redirect users_path, user: { name: "lcy",
                                            email: "valid@qq.com",
                                            password: "123456",
                                            password_confirmation: "123456" }
    end
    assert_template 'users/show'
  end
end
