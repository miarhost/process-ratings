class UploadUserRate
include Mongoid::Document
  field :payload, type: Hash
  field :received_at, type: DateTime
  field :user_id, type: Integer
  field :item_id, type: Integer
  field :value, type: Integer
  field :item_type, type: String
end
