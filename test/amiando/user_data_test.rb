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
      event_user_data = Amiando::UserData.find_all_by_event_id(event.id)
      Amiando.run

      event_user_data.result.field_names.must_equal []
    end
  end

end
