class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def hello
    # 渲染hello world文本
    render text: "hello world!"
  end

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "请登录"
      redirect_to login_path
    end
  end
end
