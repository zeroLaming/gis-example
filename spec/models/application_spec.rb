require "spec_helper"

describe Application do
  it { should have_fields(:state) }
  it { should belong_to(:opportunity).of_type(Opportunity) }
  it { should belong_to(:person).of_type(Person) }
  it { should validate_presence_of(:opportunity) }
  it { should validate_presence_of(:person) }
  it { should validate_presence_of(:state) }
  it { should be_timestamped_document }
  it { should be_timestamped_document.with(:created) }
  it { should be_timestamped_document.with(:updated) }
  
  subject { FactoryGirl.build(:application) }
  
end