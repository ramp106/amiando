module Amiando

  ##
  # http://developers.xing-events.com/index.php/REST_API_CodeDefinition
  class CodeDefinition < Resource
    map :start_date,            :creationTime,     :type => :time
    map :end_date,              :lastModified,     :type => :time

    ##
    # Fetch a code definition
    #
    # @param id
    #
    # @return [CodeDefinition]
    def self.find(id)
      object = new
      get object, "/api/codeDefinition/#{id}"

      object
    end

    ##
    # Search by code
    #
    # @param [Hash] a hash with 1 entry, either :identifier or :title
    #
    # @return [Result] with an array of result objects
    def self.find_code(event_id, code)
      object = Result.new { |response_body| response_body['code'] }
      get object, "/api/event/#{event_id}/codeDefinition/findCode", :params => { code: code }

      object
    end

    ##
    # Return all codes for a particular codeDefinition
    #
    # @param [Integer]  code definition id
    #
    # @return [Result] with an array of ids
    def self.codes(id)
      object = Result.new { |response_body| response_body['codes'] }
      get object, "/api/codeDefinition/#{id}/codes"

      object
    end

    protected

    def populate(response_body)
      extract_attributes_from(response_body, 'codeDefinition')
    end
  end
end
