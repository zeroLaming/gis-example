module Api
  module V1
    class ApplicationsController < BaseController
      around_action :execute_action
      before_action :set_opportunity
      before_action :set_application, only: [:show, :update, :destroy]
      
      def index
        applications = @opportunity.applications
        presenter = Api::V1::ApplicationsPresenter.new(applications)
        render json: pretty_json(presenter.as_json), status: 200
      end
      
      def show
        presenter = Api::V1::ApplicationPresenter.new(@application)
        render json: pretty_json(presenter.as_json), status: 200
      end
      
      def create
        @application = Application.new(application_params)
        
        if @application.save
          presenter = Api::V1::ApplicationPresenter.new(@application)
          render json: pretty_json(presenter.as_link), status: 200
        else
          presenter = Api::V1::ErrorPresenter.new(@application.errors)
          render json: pretty_json(presenter.as_json), status: 500
        end
      end
      
      def update
        if @application.update(application_params)
          presenter = Api::V1::ApplicationPresenter.new(@application)
          render json: pretty_json(presenter.as_link), status: 200
        else
          presenter = Api::V1::ErrorPresenter.new(@application.errors.first)
          render json: pretty_json(presenter.as_json), status: 500
        end
      end
      
      def destroy
        @application.destroy
        
        presenter = Api::V1::ApplicationPresenter.new(nil)
        render json: pretty_json({ status: 'OK' }), status: 200
      end
      
      protected
        def set_opportunity
          @opportunity = Opportunity.find(params[:opportunity_id])
        end
        
        def set_application
          @application = @opportunity.applications.find(params[:id])
        end
        
        def application_params
          params.require(:application).permit(:person_id, :opportunity_id, :state)
        end
    end
  end
end