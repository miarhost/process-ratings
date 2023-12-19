class UploadUserRate
include Mongoid::Document
  field :value, type: Hash
  field :received_at, type: DateTime
end
