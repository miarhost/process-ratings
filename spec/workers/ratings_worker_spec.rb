require 'rails_helper'
describe RatingsWorker, type: :worker do
  let(:payload) { {'test message' => 'test value'}.to_json }
  let(:worker_processed) { described_class.new.work(payload)}

  it 'Creates RatingsList document with expected fields' do
    expect(RatingsList.last.result).to eq(JSON.parse(payload))
  end

  it 'Results with ack to publisher' do
    expect(worker_processed).to eq :ack
  end
end
