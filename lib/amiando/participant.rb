module Amiando

  ##
  # http://developers.amiando.com/index.php/REST_API_Panticipant
  class Participant < Resource
    map :creation_time,            :creationTime,     :type => :time
    map :last_modified,            :lastModified,     :type => :time


    protected

    def populate(response_body)
      extract_attributes_from(response_body, 'participant')
    end
  end
end
