module Api
  module V1
    class OpportunitiesController < BaseController
      around_action :execute_action
      before_action :set_opportunity, only: [:show, :update, :destroy]
      
      def index
        opportunities = Opportunity.can_show_in_public_listings.page(params[:page]).per(20)
        presenter = Api::V1::OpportunitiesPresenter.new(opportunities)
        render json: pretty_json(presenter.as_json), status: 200
      end
      
      def show
        presenter = Api::V1::OpportunityPresenter.new(@opportunity)
        render json: pretty_json(presenter.as_json), status: 200
      end
      
      def create
        @opportunity = Opportunity.new(opportunity_params)
        
        if @opportunity.save
          presenter = Api::V1::OpportunityPresenter.new(@opportunity)
          render json: pretty_json(presenter.as_link), status: 200
        else
          presenter = Api::V1::ErrorPresenter.new(@opportunity.errors)
          render json: pretty_json(presenter.as_json), status: 500
        end
      end
      
      def update
        if @opportunity.update(opportunity_params)
          presenter = Api::V1::OpportunityPresenter.new(@opportunity)
          render json: pretty_json(presenter.as_link), status: 200
        else
          presenter = Api::V1::ErrorPresenter.new(@opportunity.errors)
          render json: pretty_json(presenter.as_json), status: 500
        end
      end
      
      def destroy
        @opportunity.destroy
        
        presenter = Api::V1::OpportunityPresenter.new(nil)
        render json: pretty_json({ status: 'OK' }), status: 200
      end
      
      protected
        def set_opportunity
          @opportunity = Opportunity.find(params[:id])
        end
        
        def opportunity_params
          params.require(:opportunity).permit(:title, :summary, :description, :state, :company)
        end
    end
  end
end