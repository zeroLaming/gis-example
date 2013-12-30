class Application
  include Mongoid::Document
  include Mongoid::Timestamps
  
  VALID_STATES = %w( pending approved declined )
  
  belongs_to :opportunity
  belongs_to :person
  
  validates :opportunity, presence: true
  validates :person, presence: true
  validates :state, presence: true, inclusion: { in: VALID_STATES }
  
  state_machine initial: :pending do
    event :approve do
      transition pending: :approved
    end
    
    event :decline do
      transition [:pending, :approved] => :declined
    end
  end
end