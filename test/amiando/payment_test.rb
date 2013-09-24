require 'test_helper'

describe Amiando::Payment do
  before do
    HydraCache.prefix = 'Payment'
  end

  after do
    HydraCache.prefix = nil
  end

  let(:event) { Amiando::Factory.create(:event) }

  describe 'find' do
    it 'finds a payment given the id' do
      payment_id = Amiando::Payment.sync_create(event.id).result

      payment = Amiando::Payment.find(payment_id)
      Amiando.run

      payment.id.must_equal payment_id
    end
  end

  describe 'create' do
    it 'creates a payment given valid attributes' do
      payment = Amiando::Payment.create(event.id)

      Amiando.run

      payment.result.wont_be_nil
    end

  end

end