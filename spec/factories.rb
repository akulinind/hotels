FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end

  factory :admin do
    name "admin"
    password "password"
    password_confirmation "password"
  end

  factory :hotel do
    status = ["pending", "rejected", "pending", "approved", "rejected", "pending","approved", "rejected", "pending", "approved"]

    sequence(:title) { |n| "Hotel #{n}" }
    stars 5
    breakfast true
    description "example"
    price 500
    user
    sequence(:status) {|n| status[n]}
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