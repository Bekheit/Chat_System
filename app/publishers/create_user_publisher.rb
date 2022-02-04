# class MassUpdatePublisher
#   QUEUE_NAME = 'user'.freeze

#   def initialize(user)
#     @user = user
#   end

#   def publish
#     connection = RabbitQueueService.connection
#     channel = connection.create_channel
#     p '-------------------------------------'
#     p connection
#     p '-------------------------------------'
#     queue = channel.queue(QUEUE_NAME, durable: true)
#     channel.default_exchange.publish(payload.to_json, routing_key: QUEUE_NAME)
#     # connection.close
#   end

#   private

#   def payload
#     {
#       user: @user
#     }
#   end
# end

class CreateUserPublisher
  QUEUE_NAME = 'user'.freeze

  def initialize(user)
    @user = user
  end

  def publish(options = {})
    channel = RabbitQueueService.connection.create_channel
    exchange = channel.exchange(
      ENV['BUNNY_AMQP_EXCHANGE'],
      # type: 'x-delayed-message',
      durable: true,
      # arguments: {
      #   'x-delayed-type': 'direct',
      # }
      
    )
    headers = { 'x-delay' => options[:delay_time].to_i * 1_000 } if options[:delay_time].present?
    exchange.publish(payload.to_json, routing_key: QUEUE_NAME, header:headers)
  end

  private

  def payload
    {
      user: @user
    }
  end
end