FactoryGirl.define do
  factory :person do
    name "John smith"
    sequence(:email) { |n| "#{n}#{Faker::Internet.email}" }    
  end
end