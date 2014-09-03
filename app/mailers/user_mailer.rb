class UserMailer < ActionMailer::Base
  default from: "ihaveverybigdick@gmail.com"
  def reject_hotel(hotel)
    @hotel = hotel
    mail(to: @hotel.user.email, subject: 'Your hotel rejected')
  end
  def approve_hotel(hotel)
  	@hotel = hotel
  	mail(to: @hotel.user.email, subject: 'Your hotel accepted')
  end
end
