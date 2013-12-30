module Api
  module V1
    class OpportunitiesPresenter
      
      def initialize(opportunities)
        @opportunities = opportunities
      end
      
      def as_json
        {}.tap do |h|
          h[:metadata]      = metadata
          h[:opportunities] = []
          
          @opportunities.each do |opportunity|
            h[:opportunities] << Partials::Opportunity.new(opportunity).as_json
          end
        end
      end
      
      protected
        def metadata
          current_page_num = @opportunities.current_page
          last_page_num = @opportunities.total_pages

          {
            total_count: @opportunities.total_count,
            total_pages: @opportunities.total_pages,
            first_page: UrlGenerator.new.api_v1_opportunities_url(page: 1),
            previous_page: previous_page(current_page_num),
            current_page: UrlGenerator.new.api_v1_opportunities_url(page: current_page_num),
            next_page: next_page(current_page_num, last_page_num),
            last_page: UrlGenerator.new.api_v1_opportunities_url(page: last_page_num)
          }
        end
      
        def previous_page(current_page_num)
          return nil if current_page_num <= 1
          UrlGenerator.new.api_v1_opportunities_url(page: current_page_num - 1) 
        end

        def next_page(current_page_num, last_page_num)
          return nil if current_page_num >= last_page_num
          UrlGenerator.new.api_v1_opportunities_url(page: current_page_num + 1)
        end
        
    end
  end
end