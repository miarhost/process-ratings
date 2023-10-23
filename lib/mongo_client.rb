require 'mongo'
require 'dotenv'
Dotenv.load
module MongoClient
  def host
    Rails.env == 'production' ? ENV['PROD_CLIENT_URL'] : '127.0.0.1'
  end

  def config
    @client = Mongo::Client.new(["#{host}:27017"], database: ENV['MONGO_DATABASE'],
                                user: ENV['MONGO_DB_USERNAME'],
                                password: ENV['MONGO_DB_PASSWORD'])

    @config = @client.database
    @config
  end
end
