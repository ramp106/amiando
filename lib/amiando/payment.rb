module Amiando
  class Payment < Resource

    ##
    # Create a payment for an event
    #
    # @param event_id
    #
    def self.create(event_id, attributes)
      object = new

      post object, "api/event/#{event_id}/payment/create",
        :params => attributes,
        :populate_method => :populate_create

      object
    end

    ##
    # Find a Payment
    #
    # @param payment_id
    #
    # @return [Payment] the payment with that id
    def self.find(payment_id)
      object = new
      get object, "api/payment/#{payment_id}"
      object
    end

    ##
    # Set ticket count
    #
    # @params payment_id
    # @param [Hash] amount of tickets you want to buy for this ticket category. It is possible to set the ticket count for more than one ticket category in a single request.
    #
    # @return [Payment]

    def self.set_ticket_count(payment_id, attributes)
      object = Boolean.new('success')
      post object, "api/payment/#{payment_id}/setTicketCount", :params => attributes
      object
    end

    protected

    def populate(response_body)
      extract_attributes_from(response_body, 'payment')
    end

  end
end
