require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:lcy)
  end

  test 'invalid login' do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: '', password: '' }
    assert_template
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'valid login' do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)
  end
end
