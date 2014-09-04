FactoryGirl.define do
  factory :user do
    name     "Dmitriy"
    email    "akulinind@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :hotel do
    title "Grand Hotel"
    stars 5
    breakfast true
    description "example"
    price 500
  end

  factory :adress do
    country "example"
    state "example"
    city "example"
    street "example" 
  end

  factory :rate do
    rate 5
    comment "Some comment"
    user
    hotel
  end 

end