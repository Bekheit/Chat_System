# class UserConsumer
#   connection = RabbitQueueService.connection

#   p '-----------------------------------------------'
#   p connection
#   p '-----------------------------------------------'
    
#     channel = connection.create_channel
   
#     queue = channel.queue('user', :durable => true)

#   begin
#     p ' [*] Waiting for messages. To exit press CTRL+C'
#     queue.subscribe(block: true) do |_delivery_info, _properties, body|
#       p " [x] Received #{body}"
#       user = User.find_by(id: body)
#       p user
#     end
#   rescue Interrupt => _
#     connection.close
  
    
#   end
# end

