module Api
  module V1
    class WelcomeController < BaseController
      around_action :execute_action
      
      def index
        json = Api::V1::WelcomePresenter.new.as_json
        render json: pretty_json(json), status: 200  
      end
      
    end
  end
end