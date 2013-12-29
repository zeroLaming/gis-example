class Opportunity
  include Mongoid::Document
  include Mongoid::Timestamps
  
  has_many :applications
  
  field :title, type: String
  field :summary, type: String
  field :description, type: String
  field :removed_at, type: DateTime, default: nil
  
  # I've added a company field in here to help flesh out the example API.
  # In reality this would be another collection which would have_many opportunities.
  field :company, type: String
  
  validates :title, presence: true
  validates :summary, presence: true
  
  state_machine initial: :draft do
    event :publish do
      transition draft: :available
    end
    
    event :unpublish do
      transition [:draft, :available] => :removed
    end
    
    #after_transition any => :removed do |opportunity, transition|
    #  opportunity.removed_at = Time.now
    #end
  end
  
  scope :can_show_in_public_listings, -> {
    where(state: 'available')
  }
  
  def people
    Person.in(id: applications.collect(&:person_id))
  end
end