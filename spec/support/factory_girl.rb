require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :location do
    sequence(:address) {|n| "#{n} Harrison Ave, Boston, MA" }
    name 'New Location'
    notes 'none'
    user
  end

end
