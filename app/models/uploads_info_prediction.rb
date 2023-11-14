class UploadsInfoPrediction
  include Mongoid::Document
  field :result, type: String
  field :received_at, type: DateTime
end
