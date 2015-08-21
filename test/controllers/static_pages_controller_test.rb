require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "首页 | 百助社区"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "帮助 | 百助社区"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "关于 | 百助社区"
  end
end
