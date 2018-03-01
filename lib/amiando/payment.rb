module Amiando

  ##
  # http://developers.amiando.com/index.php/REST_API_Payments
  class Payment < Resource
    ##
    # Fetch an payment
    #
    # @param id
    #
    # @return [payment]
    def self.find(id)
      object = new
      get object, "/api/payment/#{id}"

      object
    end
    
    ##
    # Return all tickets for a particular payment
    #
    # @param [Integer]  payment id
    #
    # @return [Result] with an array of ids
    def self.tickets(id)
      object = Result.new { |response_body| response_body['tickets'] }
      get object, "/api/payment/#{id}/tickets"

      object
    end
  end
end
