class RabbitQueueService
  def self.logger
    Rails.logger.tagged('bunny') do
      @@_logger ||= Rails.logger
    end
  end

  def self.connection
    @@_connection ||= begin
      instance = Bunny.new('amqp://guest:guest@rabbitmq:5672')
      
      

      instance.start
      instance
    end
  end

  
  # ObjectSpace.define_finalizer(RailsMessageQueue::Application, proc { puts "Closing rabbitmq connections"; RabbitQueueService.connection&.close })
end