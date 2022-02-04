# class MassUpdateWorker
#   include Sneakers::Worker

#   QUEUE_NAME = MassUpdatePublisher::QUEUE_NAME
#   from_queue QUEUE_NAME

#   def work(msg)
#     data = ActiveSupport::JSON.decode(msg)
#     p '--------------------------------------------'
#     p data
#     p '--------------------------------------------'
#     ack!
#   rescue StandardError => e
#     p '--------------------------------------------'
#     p 'Error'
#     p '--------------------------------------------'
#     reject!
#   end

#   private

  
# end

class CreateUserWorker
  include Sneakers::Worker

  QUEUE_NAME = CreateUserPublisher::QUEUE_NAME
  from_queue QUEUE_NAME, arguments: { 'x-dead-letter-exchange': "#{QUEUE_NAME}-retry" }

  def work(msg)
    data = ActiveSupport::JSON.decode(msg)
    p data
    user = data["user"].to_h
    user = User.new(user)
    user.save
    ack!
  rescue StandardError => e
    p e.message
    reject!
  end

  
end