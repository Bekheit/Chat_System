class MassUpdatePublisher
  QUEUE_NAME = 'user'.freeze

  def initialize(username)
    @username = username
  end

  def publish(options = {})
    connection = RabbitQueueService.connection
    
    channel = connection.create_channel
   
    queue = channel.queue('user', :durable => true)
    channel.default_exchange.publish('hello', routing_key: queue.name)
  end

  private

  def payload
    {
      username: @username
    }
  end
end