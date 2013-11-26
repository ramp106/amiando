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

    ##
    # Updates a ticket.
    #
    # @param id
    # @param [Hash] attributes
    #
    # @return [Result] if it was successful or not.
    def self.update(id, attributes)
      object = Result.new
      post object, "/api/ticket/#{id}", :params => attributes

      object
    end

    ##
    # Set user data
    #
    # @params ticket_id
    # @param [Hash] You have to send an existing <userFieldId> with the volitional value. To get the existing userDataFields you should have a look at the REST_API_Events. You could set serveral userDataFileds with one Call by separating the parameters with an "&" (e.g. <userFieldId>=foo&<otherUserFieldId>=bar).
    #
    # @return {"success": true}

    def self.set_user_data(ticket_id, user_data)
      object = Boolean.new('success')
      post object, "api/ticket/#{ticket_id}/userData", :params => user_data
      object
    end

    protected

    def populate(response_body)
      extract_attributes_from(response_body, 'ticket')
    end
  end
end
