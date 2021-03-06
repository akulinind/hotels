class AdminsController < ApplicationController
  include AdminsSessionsHelper

  before_action :admin_signed_in, only: [:edit, :update]

  def new
    @admin = Admin.new
  end

  def home
    if params[:search].nil?
      unless params[:sort_by].nil?
        @users = User.send(params[:sort_by])
      else
        @users = User.all  
      end
    else
      @users = User.search(params[:search])
    end  
  end

 


  def hotels
    @hotels = Hotel.search(params[:search])
 #   @Hotels = Hotel.search(params[:search]) unless params[:search].blank?
  end


  def update
    if params.has_key?(:status)
      @hotel = Hotel.find(params[:id])
      hotel.update_attribute('status', params[:status])
      if params[:status] == "rejected" 
        UserMailer.reject_hotel(hotel).deliver
      elsif param[:status] == "approved"
        UserMailer.approve_hotel(hotel).deliver
      end     
      redirect_to admins_hotels_path
    end
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
