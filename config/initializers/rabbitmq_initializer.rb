class RabbitQueueService
  
  def self.connection
    @@_connection ||= begin
      instance = Bunny.new(
        addresses: ENV['BUNNY_AMQP_ADDRESSES'],
        username:  ENV['BUNNY_AMQP_USER'],
        password:  ENV['BUNNY_AMQP_PASSWORD'],
        vhost:     ENV['BUNNY_AMQP_VHOST'],
      )
      p '-------------------------------------'
      p instance
      p '-------------------------------------'
      instance.start
      instance
    end
  end

end