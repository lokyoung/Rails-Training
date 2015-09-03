class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_param)
    if @user.save
      log_in @user
      flash[:success] = "欢迎来到百助社区!"
      # 这里 @user 等同于 user_url(@user)
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  private
    def user_param
      params.require(:user).permit(:name, :email,
                                   :password, :password_confirmation)
    end
end
