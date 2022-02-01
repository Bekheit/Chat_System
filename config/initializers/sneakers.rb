require 'sneakers'
require 'sneakers/handlers/maxretry'

module Connection
  def self.sneakers
    @_sneakers ||= begin
      Bunny.new('amqp://guest:guest@rabbitmq:5672')
    end
  end
end



Sneakers.configure  connection: Connection.sneakers,
                    runner_config_file: nil,                             # A configuration file (see below)
                    metric: nil,                                         # A metrics provider implementation
                    daemonize:false,                                     # Send to background
                    log: STDOUT,                                         # Log file
                    pid_path: 'sneakers.pid',                            # Pid file
                    timeout_job_after: 5.minutes,                        # Maximal seconds to wait for job
                    prefetch: 10,             # Grab 10 jobs together. Better speed.
                    threads: 10,               # Threadpool size (good to match prefetch)
                    env: ENV['RAILS_ENV'],                               # Environment
                    durable: true,                                       # Is queue durable?
                    ack: true,                                           # Must we acknowledge?
                    heartbeat: 5,                                        # Keep a good connection with broker
                    # TODO: implement exponential back-off retry
                    handler: Sneakers::Handlers::Maxretry,
                    retry_max_times: 10,                                  # how many times to retry the failed worker process
                    retry_timeout: 3 * 60 * 1000                        # how long between each worker retry duration

