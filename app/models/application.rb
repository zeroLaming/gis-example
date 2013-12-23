class Application
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :opportunity
  belongs_to :person
  
  field :source, type: String
end