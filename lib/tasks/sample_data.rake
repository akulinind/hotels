namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    Admin.create!(name: 'admin', password: '555555', password_confirmation: '555555')

    User.create!(name: "Example User",
                 email: "Example@user.com",
                 password: "123456",
                 password_confirmation: "123456")
    

    15.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@example.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end


    users = User.first(15)

    rg = Random.new
    
    20.times do
      hotel = Hotel.new(title: Faker::Company.name + " Hotel",
                            stars: rg.rand(5),
                            breakfast: rg.rand(2) == 1,
                            description: Faker::Lorem.paragraph,
                            price: rg.rand(200..2000),
                            status: "Rejected")

      hotel.user = users[rg.rand(15)]
      hotel.build_address(country: Faker::Address.country,
                             city: Faker::Address.city,
                            state: Faker::Address.state_abbr, 
                           street: Faker::Address.street_address)
      hotel.save

      rates_number = rg.rand(1..10)

      rates_number.times do
        hotel_rate = rg.rand(1..5)
        rate = hotel.rates.build(rate: hotel_rate, comment: Faker::Lorem.sentence)
        rate.user = users[rg.rand(15)]
        rate.save

        hotel.rates_total += hotel_rate;
      end

      hotel.rate_avg = hotel.rates_total.to_f / rates_number;
      hotel.save


    end  

    20.times do
      hotel = Hotel.new(title: Faker::Company.name + " Hotel",
                            stars: rg.rand(5),
                            breakfast: rg.rand(2) == 1,
                            description: Faker::Lorem.paragraph,
                            price: rg.rand(200..2000),
                            status: "Pending")

      hotel.user = users[rg.rand(15)]
      hotel.build_address(country: Faker::Address.country,
                             city: Faker::Address.city,
                            state: Faker::Address.state_abbr, 
                           street: Faker::Address.street_address)
      hotel.save

      rates_number = rg.rand(1..10)

      rates_number.times do
        hotel_rate = rg.rand(1..5)
        rate = hotel.rates.build(rate: hotel_rate, comment: Faker::Lorem.sentence)
        rate.user = users[rg.rand(15)]
        rate.save

        hotel.rates_total += hotel_rate;
      end

      hotel.rate_avg = hotel.rates_total.to_f / rates_number;
      hotel.save


    end  

    20.times do
      hotel = Hotel.new(title: Faker::Company.name + " Hotel",
                            stars: rg.rand(5),
                            breakfast: rg.rand(2) == 1,
                            description: Faker::Lorem.paragraph,
                            price: rg.rand(200..2000),
                            status: "Approved")

      hotel.user = users[rg.rand(5)]
      hotel.build_address(country: Faker::Address.country,
                             city: Faker::Address.city,
                            state: Faker::Address.state_abbr, 
                           street: Faker::Address.street_address)
      hotel.save

      rates_number = rg.rand(1..10)

      rates_number.times do
        hotel_rate = rg.rand(1..5)
        rate = hotel.rates.build(rate: hotel_rate, comment: Faker::Lorem.sentence)
        rate.user = users[rg.rand(5)]
        rate.save

        hotel.rates_total += hotel_rate;
      end

      hotel.rate_avg = hotel.rates_total.to_f / rates_number;
      hotel.save


    end  
     

  end
end