module Amiando

  class UserData < Resource
    ##
    # @param event_id
    #
    # @return [Result] with all the used data fields for this event.
    def self.find_all_by_event_id(event_id)
      object = Result.new do |response_body, result|
        if response_body['success']
          OpenStruct.new(:field_names => response_body['userData'])
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
