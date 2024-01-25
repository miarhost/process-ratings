
set :output, "#{path}/log/cron.log"
env 'WORKERS', 'ImportancesWorker, LinksPublisherWorker, IndRatesCollectWorker, LinksParserWorker, LinksPublisherWorker, MappedPredictionsWorker, RatingsWorker'

every 1.day, at: '14:58 pm' do
  rake 'sneakers:run'
end
