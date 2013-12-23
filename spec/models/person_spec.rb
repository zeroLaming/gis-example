require "spec_helper"

describe Person do
  it { should have_fields(:name, :email) }
  it { should have_many(:applications).of_type(Application) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should be_timestamped_document }
  it { should be_timestamped_document.with(:created) }
  it { should be_timestamped_document.with(:updated) }
  
  subject { FactoryGirl.build(:person) }
  
  context "regular person" do
    it { should be_valid }
  end
  
  describe "email addresses" do
    context "when email address is empty" do
      subject { FactoryGirl.build(:person, email: '') }
      it { should_not be_valid }
    end
    
    context "when email address is valid" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        subject { FactoryGirl.create(:person, email: address) }
        it { should be_valid }
      end
    end
    
    context "when email address is invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        subject { FactoryGirl.build(:person, email: address) }
        it { should_not be_valid }
      end
    end
  end
end