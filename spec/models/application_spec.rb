require "spec_helper"

describe Application do
  it { should belong_to(:opportunity).of_type(Opportunity) }
  it { should belong_to(:person).of_type(Person) }
  it { should be_timestamped_document }
  it { should be_timestamped_document.with(:created) }
  it { should be_timestamped_document.with(:updated) }
  
  subject { FactoryGirl.build(:application) }
  
end