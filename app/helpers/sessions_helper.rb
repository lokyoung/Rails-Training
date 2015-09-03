module SessionsHelper
  def log_in(user)
    # 这里的session和session controller不一样，是Rails内置的方法
    session[:user_id] = user.id
  end

  def current_user
    # 如果当前用户为空，则@current_user = User.find_by(id: session[:user])
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
