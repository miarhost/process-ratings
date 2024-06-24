Rails.application.config.active_support.key_generator_hash_digest_class = OpenSSL::Digest::SHA256

# Change the digest class for ActiveSupport::Digest.
# Changing this default means that for example Etags change and
# various cache keys leading to cache invalidation.
  Rails.application.config.active_support.hash_digest_class = OpenSSL::Digest::SHA256

# Don't override ActiveSupport::TimeWithZone.name and use the default Ruby
# implementation.
  Rails.application.config.active_support.remove_deprecated_time_with_zone_name = true

  Rails.application.config.active_record.legacy_connection_handling = false
