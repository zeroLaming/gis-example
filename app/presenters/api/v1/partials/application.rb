module Api
  module V1
    module Partials
      class Application
      
        def initialize(application)
          @application = application
        end
      
        def as_json
          {
            id: @application.id.to_s,
            status: @application.state,
            url: UrlGenerator.new.api_v1_opportunity_application_url(@application.opportunity, @application),
            opportunity: {
              id: @application.opportunity.id.to_s,
              title: @application.opportunity.title
            },
            person: {
              id: @application.person.id.to_s,
              name: @application.person.name
            },
            created_at: @application.created_at,
            updated_at: @application.updated_at
          }
        end
      end
    end
  end
end