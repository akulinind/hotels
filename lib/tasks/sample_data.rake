namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@mail.com",
                 password: "123456",
                 password_confirmation: "123456")
    

    5.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@example.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end


    users = User.first(6)

    rg = Random.new
    
    50.times do
      hotel = Hotel.new(title: Faker::Company.name + " Hotel",
                            stars: rg.rand(5),
                            breakfast: rg.rand(2) == 1,
                            description: Faker::Lorem.paragraph,
                            price: rg.rand(200..2000))

      hotel.user = users[rg.rand(5)]
      hotel.build_address(country: Faker::Address.country,
                             city: Faker::Address.city,
                            state: Faker::Address.state_abbr, 
                           street: Faker::Address.street_address)
      hotel.save

      7.times do
        hotel_rate = rg.rand(1..5)
        rate = hotel.rates.build(rate: rg.rand(1..5), comment: Faker::Lorem.sentence)
        rate.user = users[rg.rand(5)]
        rate.save
        hotel.rate_total += hotel_rate
      end
      hotel.rate_avg = hotel.rates_total.to_f / 7
      hotel_save

    end  
     

  end
end