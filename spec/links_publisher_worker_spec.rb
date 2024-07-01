require 'rails_helper'
require 'sneakers'
require 'serverengine'

describe LinksPublisherWorker, type: :worker do
  let!(:payload) { ['https://example_1.com?download%params',
    'https://example_2.com?download%params',
    'https://example_3.com?download%params'] }
  let!(:routing_key) {'test_queue'}

  let!(:delivery_info) {{routing_key: } }
  let!(:metadata) { {content_type: 'application/json', delivery_mode: 2, priority: 2}}
  let!(:processor) { described_class.new(routing_key, 'test') }

  let!(:unappropriate_payload) { 'Not a valid format' }


  context 'successful publishing triggered by links document creation' do
    it 'successfully publishes payload' do
      TopicsList.create!(document: payload )
      expect(processor.work_with_params( payload, delivery_info, metadata)).to eq(:ack)
    end
  end

  context 'errors in delivering process' do
    it 'fails to publish payload' do
      expect(processor.work_with_params( unappropriate_payload, delivery_info, metadata)).not_to eq(:ack)
    end
  end
end
