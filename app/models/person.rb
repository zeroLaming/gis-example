class Person
  include Mongoid::Document
  include Mongoid::Timestamps
  
  has_many :applications
  
  field :name, type: String
  field :email, type: String
  
  validates :name, presence: true
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  
  # We don't have a way to do a has_many :through with mongo.
  # This is an example method to demonstrate the relationship.
  # Loading these documents into memory is likely to get expensive 
  # with a bigger data set.
  def opportunities
    Opportunity.in(id: applications.collect(&:opportunity_id))
  end
end