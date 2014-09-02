class HotelsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]

  def index
    @hotels = Hotel.search(params[:search])
  end

  def show
    @hotel = Hotel.find(params[:id])
    @rates = @hotel.rates.paginate(page: params[:page])
    @rate = @hotel.rates.build
  end

  def new
    @hotel = Hotel.new
    @address = @hotel.build_address
  end

  def update
    if params.has_key?(:new_status)
      hotel = Hotel.find(params[:id])
      hotel.update_attribute('status', params[:status])
      redirect_to admins_hotels_path
    end
  end

  def create
    @hotel = Hotel.new(hotel_params) 
    @hotel.user = current_user
    @address = @hotel.build_address(address_params)
    if @hotel.save && @address.save
      flash[:success] = "New hotel was added successfully"  
      redirect_to hotels_url
    else
      render 'new'
    end
  end


private

    def hotel_params
      params.require(:hotel).permit(:title, :stars, :breakfast, :description, :price, :photo)
    end

    def address_params
      params.require(:address).permit(:country, :city, :state, :street)
    end
    
end