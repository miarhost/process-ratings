
  class IndRatesProcessing
    include Mongoid::Document
    include MongoClient
    class << self
      def max_rate
        UploadUserRate.collection.aggregate(
          [
            { '$match'=> { "item_type" => "Upload" }},
            { '$group'=>
              {
                _id: "$item_id",
                maxRate: { "$max" => "$rates" },
                submittedCount: { "$count" => "$user_ids"}
              }
            }
          ]
        )
      end
    end
  end
