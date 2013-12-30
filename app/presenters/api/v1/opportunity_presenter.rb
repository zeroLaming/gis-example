module Api
  module V1
    class OpportunityPresenter
      
      def initialize(opportunity)
        @opportunity = opportunity
      end
      
      def as_json
        Partials::Opportunity.new(@opportunity).as_json
      end
      
      def as_link
        {
          id: @opportunity.id.to_s,
          url: ::UrlGenerator.new.api_v1_opportunity_url(@opportunity)
        }
      end
    end
  end
end