FactoryGirl.define do
  factory :payment do
    client
    amount_in_cents { rand(99999) }
    note { Faker::Company.bs }
    payment_type { ["revenue", "expense"].sample }
  end
end