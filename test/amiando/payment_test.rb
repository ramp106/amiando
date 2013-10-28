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

  describe 'set_ticket_count' do
    it 'set ticket count' do
      ticket_category = Amiando::Factory.create(:ticket_category)
      payment = Amiando::Payment.sync_create(event.id, {})
      result = Amiando::Payment.set_ticket_count(payment.id, {ticket_category.id => 1})

      Amiando.run

      result.success.must_equal true
    end
  end

  describe 'populate_create' do
    let(:payment) { Amiando::Payment.new }

    it 'set application_data' do
      payment.populate_create({"payment" => {"applicationData" => "test data"}})
      payment.application_data.must_equal "test data"
    end

    it 'do not set application_data' do
      payment.populate_create({"payment" => "invalid data"})
      payment.respond_to?(:application_data).must_equal false
    end
  end
end