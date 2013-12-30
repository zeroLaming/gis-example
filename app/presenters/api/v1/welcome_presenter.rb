module Api
  module V1
    class WelcomePresenter
      
      def as_json
        {
          endpoints: endpoints
        }
      end
      
      protected
        def endpoints
          Rails.application.routes.routes.map{ |r| r.path.spec.to_s }.delete_if{ |r| r !~ /api\/v1/ }.uniq.sort
        end
    end
  end
end