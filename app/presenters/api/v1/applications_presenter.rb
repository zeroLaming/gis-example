module Api
  module V1
    class ApplicationsPresenter
      
      def initialize(applications)
        @applications = applications
      end
      
      def as_json
        {}.tap do |h|
          h[:applications] = []
          
          @applications.each do |application|
            h[:applications] << Partials::Application.new(application).as_json
          end
        end
      end
      
    end
  end
end