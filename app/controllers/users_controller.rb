class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)  
    if admin_signed_in? && @user.save
      redirect_to admin_dashboard_path
    else  
      if @user.save 
        UserMailer.welcome_email(@user).deliver
        sign_in @user
        flash[:success] = "Welcome to the Hotels Rating Web Site!" 
        redirect_to root_url
      else
        render 'new'
      end
    end 
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to admin_dashboard_path
  end

  def show
      @user = User.find(params[:id])
  end    

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to edit_user_path
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) or admin_signed_in?
    end



end