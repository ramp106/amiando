module Amiando

  ##
  # http://developers.amiando.com/index.php/REST_API_Tickets
  class Ticket < Resource

    ##
    # Find a list of tickets
    #
    # @param [Hash] Hash with search options
    # @return [Result] with the ticket id's
    def self.search(by = {})
      object = Result.new { |response_body| response_body['ids'] }
      get object, '/api/ticket/find', :params => by

      object
    end
    
    ##
    # Find a ticket.
    # Will return a ticket
    #
    # @param ticket_id
    def self.find(ticket_id)
      object = new
      get object, "api/ticket/#{ticket_id}"

      object
    end
    
    protected

    def populate(response_body)
      extract_attributes_from(response_body, 'ticket')
    end
    
  end

end
