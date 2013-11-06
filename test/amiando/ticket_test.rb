require 'test_helper'

describe Amiando::Ticket do
  before do
    HydraCache.prefix = 'Ticket'
  end

  after do
    HydraCache.prefix = nil
  end

  let(:event) { Amiando::Factory.create(:event) }

  describe '.find_all_by_payment_id(payment_id)' do
    it 'fetches ticket ids for a payment' do
      payment = Amiando::Payment.sync_create(event.id, {})

      tickets = Amiando::Ticket.find_all_by_payment_id(payment.id)
      Amiando.run

      tickets.result.must_equal []
    end
  end

  describe '.find(id)' do
    it 'fetches ticket by id' do
      # ticket = Amiando::Ticket.find(1)
    end
  end

  describe 'update' do
    it 'updates the ticket' do
    end
  end
end
