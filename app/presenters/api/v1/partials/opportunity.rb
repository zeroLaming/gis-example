module Api
  module V1
    module Partials
      class Opportunity
      
        def initialize(opportunity)
          @opportunity = opportunity
        end
      
        def as_json
          {
            id: @opportunity.id.to_s,
            title: @opportunity.title,
            summary: @opportunity.summary,
            description: @opportunity.description,
            url: ::UrlGenerator.new.api_v1_opportunity_url(@opportunity),
            company: {
              name: @opportunity.company
            }
          }
        end
      end
    end
  end
end