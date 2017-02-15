# The health_index_path route is pinged frequently. We don't want that to clutter
# our main log file, so we intercept all calls to that route and change the logger.
module ServerHealthCheckRailsOsm
  class Logger
    FILE_NAME = "health_check.log"

    class << self
      delegate :config, to: :"::Rails.application"

      def log_file
        @log_file ||= begin
          # rubocop:disable Style/AutoResourceCleanup
          f = File.open Rails.root.join("log", FILE_NAME), "a"
          # rubocop:enable Style/AutoResourceCleanup
          f.binmode
          f.sync = config.autoflush_log # if true make sure every write flushes
          f
        end
      end

      # This logger is constructed identically to the Rails logger (see
      # https://github.com/rails/rails/blob/v5.0.0.1/railties/lib/rails/application/bootstrap.rb#L39)
      # but with a different file name.
      def logger
        @logger ||= begin
          logger = ActiveSupport::Logger.new log_file
          logger.formatter = config.log_formatter
          logger = ActiveSupport::TaggedLogging.new(logger)
          logger.level = ActiveSupport::Logger.const_get(config.log_level.to_s.upcase)
          logger
        end
      end

      def choose_logger(object:, env:)
        path = env[::Rack::REQUEST_PATH] || env['ORIGINAL_FULLPATH'] || env.fetch("REQUEST_URI")
        logger_klass = ServerHealthCheckRails::Engine.routes.url_helpers.health_index_path == path ? to_s : :Rails
        (class << object; self; end).class_eval do
          delegate :logger, to: logger_klass
        end
      end
    end
  end

  Module.new do
    def start_processing(event)
      ServerHealthCheckRailsOsm::Logger.choose_logger(object: self, env: event.payload[:headers].env)
      super
    end

    ActionController::Base.tap { } # Autoload so that LogSubscriber is defined
    ActionController::LogSubscriber.prepend self
  end

  Module.new do
    def call(env)
      ServerHealthCheckRailsOsm::Logger.choose_logger(object: self, env: env)
      super
    end

    Rails::Rack::Logger.prepend self
  end
end
