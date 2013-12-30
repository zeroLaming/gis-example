require 'faker'

# Create some people
20.times do |n|
  Person.create!(name: Faker::Name.name, email: "#{n}-#{Faker::Internet.email}")
end

# Create some opportunities
100.times do |n|
  opportunity = Opportunity.new.tap do |o|
    o.title = Faker::Lorem.words(4).join(' ')
    o.summary = Faker::Lorem.sentence(1)
    o.description = Faker::Lorem.sentence(6)
    o.company = Faker::Company.name
    
    o.publish
    o.save!
  end
  
  # Create some applications for the opportunity
  (1 + rand(10)).times do |i|
    opportunity.applications.create!(person: Person.all.sample)
  end
end