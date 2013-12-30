module Api
  module V1
    class BaseController < ActionController::Base
      skip_before_action :verify_authenticity_token
      
      # This method should execute around all API methods.
      # In production we'd do more here, like app / user authentication /
      # / checking the request has been signed correctly.
      # For now though, we'll just log the request time and handle any exceptions.
      def execute_action
        @request_start_time = Time.now
        begin
          yield
          record_request_time
        rescue StandardError => ex
          record_request_time
          handle_exception(ex)
        end
      end
      
      # Catch exceptions in our API and return an error object
      def handle_exception(ex)
        render json: Api::V1::ErrorPresenter.new(ex.message.to_s).as_json, status: 500  
      end
      
      # We can make this method conditional in production
      # if we want to speed the API up a bit.
      def pretty_json(json)
        JSON.pretty_generate(json) 
      end
      
      # Record how long this API call took to execute.
      # In production we'd run analytics to determine where the bottlenecks are.
      # For now though let's just log it.
      def record_request_time
        elapsed_time = (Time.now - @request_start_time) * 1000.0
        logger.info "Time: #{elapsed_time}, Size: #{response.body.length}"
      end
      
    end
  end
end