module Amiando

  class UserData < Resource
    ##
    # @param event_id
    #
    # @return [Result] with all the used data fields for this event.
    def self.find_all_by_event_id(event_id)
      object = Result.new do |response_body, result|
        if response_body['success']
          # ticket_types = response_body['results']['User'].map do |ticket_type|
          #   new(ticket_type)
          # end

          # available = response_body['results']['availableTicketTypes']

          # OpenStruct.new(:ticket_types => ticket_types,
          #                :available_ticket_types => available)
          OpenStruct.new(:user_data => response_body['results'])
        else
          result.errors = response_body['errors']
          false
        end
      end

      get object, "api/event/#{event_id}/userData"

      object
    end

  end

end
