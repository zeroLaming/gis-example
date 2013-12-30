module Api
  module V1
    class ErrorPresenter
      attr_reader :message
      
      def initialize(message)
        @message = message
      end
      
      def as_json
        {
          error_message: @message
        }
      end
    end
  end
end