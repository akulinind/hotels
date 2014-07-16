FactoryGirl.define do
  factory :user do
    name     "Dmitriy"
    email    "akulinind@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :hotel do
  end 
  
  factory :rate do
    rate 5
    comment "Some comment"
    user
    hotel
  end 

end