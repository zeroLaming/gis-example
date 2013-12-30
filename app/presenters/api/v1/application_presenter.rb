module Api
  module V1
    class ApplicationPresenter
      
      def initialize(application)
        @application = application
      end
      
      def as_json
        Partials::Application.new(@application).as_json
      end
      
      def as_link
        {
          id: @application.id.to_s,
          url: ::UrlGenerator.new.api_v1_opportunity_application_url(@application.opportunity, @application)
        }
      end
    end
  end
end