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
      original = Amiando::Payment.sync_create(event.id, {})

      payment = Amiando::Payment.find(original.id)
      Amiando.run

      payment.id.must_equal original.id
    end
  end

  describe 'create' do
    it 'creates a payment given valid attributes' do
      payment = Amiando::Payment.create(event.id, {})

      Amiando.run

      payment.id.wont_be_nil
      payment.success.must_equal true
    end

  end

end