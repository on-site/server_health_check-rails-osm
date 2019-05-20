require "server_health_check_rails/engine"

module ServerHealthCheckRailsOsm
  class Engine < ::Rails::Engine
    isolate_namespace ServerHealthCheckRailsOsm

    config.after_initialize do
      ServerHealthCheckRailsOsm::Patches.apply_patches
    end

    initializer "server_health_check_rails_osm.patch_log_subscriber" do
      ActiveSupport.on_load(:action_controller) do
        ActionController::LogSubscriber.prepend LogSubscriber
      end
    end

    initializer "server_health_check_rails_osm.patch_rack_logger" do
      ActiveSupport.on_load(:action_controller) do
        Rails::Rack::Logger.prepend RackLogger
      end
    end

    initializer "server_health_check_rails_osm.bypass_ssl_for_health_index_path" do |app|
      # Allow access to health_index_path via HTTP.
      app.config.ssl_options ||= {}
      app.config.ssl_options[:redirect] ||= {}
      original_exclude = app.config.ssl_options[:redirect][:exclude]
      app.config.ssl_options[:redirect][:exclude] = ->(request){
        ServerHealthCheckRails::Engine.routes.url_helpers.health_index_path == request.path ||
          (original_exclude && original_exclude.call(request))
      }
    end
  end
end
