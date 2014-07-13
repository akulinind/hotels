class StaticPagesController < ApplicationController
  def home
  	@hotels = Hotel.take(5)
  end
end
