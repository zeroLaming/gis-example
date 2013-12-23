require "spec_helper"

describe Opportunity do
  it { should have_fields(:title, :summary, :description, :state, :removed_at) }
  it { should have_many(:applications).of_type(Application) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:summary) }
  it { should be_timestamped_document }
  it { should be_timestamped_document.with(:created) }
  it { should be_timestamped_document.with(:updated) }
  
  subject { FactoryGirl.build(:opportunity) }
  
  context "regular opportunity" do
    it { should be_valid }
  end
  
  describe "state" do
    context "when a new opportunity is created" do
      subject { FactoryGirl.build(:opportunity).state }
      it { should == 'draft' }
    end
    
    context "when an opportunity is published" do
      subject { 
        FactoryGirl.build(:opportunity).tap do |o|
          o.publish
        end.state
      }
      it { should == 'available' }
    end
    
    context "when an opportunity is unpublished" do
      subject { 
        FactoryGirl.build(:opportunity).tap do |o|
          o.publish
          o.unpublish
        end.state
      }
      it { should == 'removed' }
    end
  end
  
end