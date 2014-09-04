class UserMailer < ActionMailer::Base
  default from: "ihaveverybigdick@gmail.com"
	
	def welcome_email(user)
	  @user = user
	  mail(to: @user.email, subject: 'Welcome to Hotel Advisor')
	end 	

  def reject_hotel(hotel)
    @hotel = hotel
    mail(to: @hotel.user.email, subject: 'Your hotel rejected')
  end
  def approve_hotel(hotel)
  	@hotel = hotel
  	mail(to: @hotel.user.email, subject: 'Your hotel accepted')
  end
end
