class StaticPagesController < ApplicationController
  def home
  	@hotels = Hotel.where("status='approved'").take(5)
  end
end
