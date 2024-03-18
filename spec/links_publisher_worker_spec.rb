require 'rails_helper'

describe LinksPublisherWorker, type: :worker do
  let!(:payload) { ['https://example_1.com?download%params',
    'https://example_2.com?download%params',
    'https://example_3.com?download%params'] }

  let(:routing_key) { 'parsed.links' }
  let(:metadata) { {:content_type=>"application/octet-stream", :delivery_mode=>2, :priority=>0}}
  let(:worker_processed_good) { described_class.new.work_with_params('', { routing_key: routing_key }, metadata)}

  let(:worker_processed_bad) { described_class.new.work_with_params('', {}, {})}


  context 'successful deliver to consumers' do
    it 'successfully sends payload to a consumer with ack' do
      expect(worker_processed_good).to eq(:ack)
      worker_processed_good
    end
  end

  context 'errors in delivering process' do
    it 'interrups delivering and logs full error trace' do
      expect(Sneakers.logger).to receive(:error).with(a_string_including("stopped delivering at"))
      worker_processed_bad
    end
  end
end
