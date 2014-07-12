FactoryGirl.define do
  factory :user do
    name     "Dmitriy"
    email    "akulinind@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end
end