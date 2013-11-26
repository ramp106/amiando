require "test_helper"

describe Amiando::UserData do
  before do
    HydraCache.prefix = 'UserData'
  end

  after do
    HydraCache.prefix = nil
  end

  let(:event) { Amiando::Factory.create(:event) }

  describe 'find_all_by_event_id' do
    it 'fetches user data fields for the event' do
      user_data = Amiando::UserData.find_all_by_event_id(event.id)
      Amiando.run

      #found.result.must_include ticket_category.id
      puts user_data.inspect
    end
  end

end
