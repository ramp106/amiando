module Amiando
  class Payment < Resource

    ##
    # Create a payment for an event
    #
    # @param event_id
    #
    def self.create(event_id)
      object = Result.new do |response_body, result|
        result.errors = response_body['errors']
        response_body['id'] || false
      end

      post object, "api/event/#{event_id}/payment/create", :params => { }

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

    protected

    def populate(response_body)
      extract_attributes_from(response_body, 'payment')
    end

  end
end
