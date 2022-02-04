# require 'bunny'

# connection = Bunny.new(
#           addresses: ENV['BUNNY_AMQP_ADDRESSES'],
#           username:  ENV['BUNNY_AMQP_USER'],
#           password:  ENV['BUNNY_AMQP_PASSWORD'],
#           vhost:     ENV['BUNNY_AMQP_VHOST'],
#           automatically_recover: true,
#           connection_timeout: 2,
#           continuation_timeout: (10_000).to_i,
#         )
# connection.start
# channel = connection.create_channel
# queue = channel.queue('user', durable: true)

# begin
#   puts ' [*] Waiting for messages. To exit press CTRL+C'
#   # block: true is only used to keep the main thread
#   # alive. Please avoid using it in real world applications.
#   queue.subscribe(block: true) do |_delivery_info, _properties, body|
#     puts " [x] Received #{body}"
#   end
# rescue Interrupt => _
#   connection.close

#   exit(0)
# end

require 'sneakers'
require 'sneakers/handlers/maxretry'

module Connection
  def self.sneakers
    @_sneakers ||= begin
      Bunny.new(
        addresses: ENV['BUNNY_AMQP_ADDRESSES'],
        username:  ENV['BUNNY_AMQP_USER'],
        password:  ENV['BUNNY_AMQP_PASSWORD'],
        vhost:     ENV['BUNNY_AMQP_VHOST'],
        automatically_recover: true,
        connection_timeout: 2,
        continuation_timeout: (10_000).to_i,
      )
    end
  end
end



Sneakers.configure  connection: Connection.sneakers,
                    exchange: 'sneakers',
                    exchange_type: :direct,
                    runner_config_file: nil,
                    metric: nil,
                    workers: 1,
                    log: STDOUT,
                    pid_path: 'sneakers.pid',
                    timeout_job_after: 5.minutes,
                    env: ENV['RAILS_ENV'], 
                    durable: true,
                    ack: true,
                    heartbeat: 2,
                    handler: Sneakers::Handlers::Maxretry
Sneakers.logger = Rails.logger
Sneakers.logger.level = Logger::WARN