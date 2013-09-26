module Amiando
  class Ticket < Resource

    ##
    # Find all tickets from a payment
    #
    # @param user_id
    #
    # @return [Result] with a list of the ticket ids by this payment
    def self.find_all_by_payment_id(payment_id)
      object = Result.new do |response_body|
        response_body['tickets']
      end
      get object, "/api/payment/#{payment_id}/tickets"
      object
    end

    ##
    # Find a Ticket
    #
    # @param id
    #
    # @return [Ticket] the ticket with that id
    def self.find(id)
      object = new
      get object, "api/ticket/#{id}"
      object
    end

    protected

    def populate(response_body)
      extract_attributes_from(response_body, 'ticket')
    end
  end
end
