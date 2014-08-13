class AdminsController < ApplicationController

  before_action :signed_in_admin, only: [:edit, :update]
  before_action :correct_admin,   only: [:edit, :update]

  def new
    @admin = Admin.new
  end

  def home
    @users = User.order(params[:sort]) 
  end




  #def create
  #  @user = Admin.new(Admin_params)  
  #  if @user.save
  #    sign_in @admin
  #    flash[:success] = "Welcome to the Hotels Rating Web Site!" 
 #   else
 #    render 'new'
 #   end
 # end

  def edit
  end

 # def show
 #     @user = User.find(params[:id])
 # end    

#  def update
#    if @user.update_attributes(user_params)
#      flash[:success] = "Profile updated"
#      redirect_to root_url
#    else
#      render 'edit'
#    end
#  end
 # def new
 # end



end
