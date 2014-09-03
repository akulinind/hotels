class StaticPagesController < ApplicationController
  def home
  	@hotels = Hotel.take(5).where(status:"Approved")
  end
end
