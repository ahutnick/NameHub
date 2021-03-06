class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show, :destroy]
  before_action :correct_user, only: [:edit, :update, :show, :destroy]
  
  def show
    @user = User.find(params[:id])
    @activities = current_user.activities.order(created_at: :desc)[0, 5]
  end
  
  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Welcome to #{@user.name}Hub!"
      redirect_to(@user)
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Deleted"
    redirect_to home_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit( :name,
                                  :email,
                                  :password,
                                  :password_confirmation
    )
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_path
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to home_path unless current_user?(@user)
  end
end
