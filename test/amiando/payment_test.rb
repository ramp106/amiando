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

  describe 'start_payment' do
    it 'start payment' do
      payment = Amiando::Payment.sync_create(event.id, {})
      result = Amiando::Payment.sync_start_payment(payment.id).result

      result.start_identifier.must_equal "99Cbbic8ox2cIhOr"
      result.start_url.must_equal "https://de.pub-test.ostack.muc.amiando.local/OKRRXRE.html?startIdentifier=99Cbbic8ox2cIhOr&queueIdentifier=550d7e2b-6f2f-4c91-8736-b767bee19b84&viewType=iframe"
      result.queue_identifier.must_equal "550d7e2b-6f2f-4c91-8736-b767bee19b84"
    end
  end

  describe 'populate_create' do
    let(:payment) { Amiando::Payment.new }

    it 'set application_data' do
      payment.populate_create({"payment" => {"applicationData" => "test data"}})
      payment.application_data.must_equal "test data"
    end

    it 'do not set application_data' do
      payment.populate_create({})
      payment.respond_to?(:application_data).must_equal false
    end
  end
end