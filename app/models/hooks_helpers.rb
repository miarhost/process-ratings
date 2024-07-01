module HooksHelpers
  def sneakers_config
    if Rails.env.test?
      {queue_name: 'test_queue', exchange: 'test'}
    else
      {queue_name:, exchange: 'snickers'}
    end
  end

  def queue_name; 'default'; end
end
