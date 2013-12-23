FactoryGirl.define do
  factory :application do
    association :opportunity, factory: :opportunity
    association :person, factory: :person
  end
end