require 'rails_helper'
describe ImportancesWorker, type: :worker do
  let!(:payload) {
    [
      { 'id': 3, 'importance': 56 },
      { 'id': 1 , 'importance': 90 }
    ]
  }

  let(:worker_processed) { described_class.new.work(payload) }

  it 'creates ImportanceList record with payload and timestamp' do
    expect(ImportanceList.last.values).to eq(JSON.parse(payload))
  end

  it 'results with ack to publisher' do
    expect(:worker_processed).to eq :ack!
  end
end
