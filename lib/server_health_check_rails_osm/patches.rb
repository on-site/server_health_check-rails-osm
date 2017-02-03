module ServerHealthCheckRailsOsm
  module Patches
    @@patches_applied = false

    def self.apply_patches
      return if @@patches_applied
      @@patches_applied = true
      Rails.logger.info "Applying server_health_check-rails-osm patches"
      ServerHealthCheckRails::HealthCheck.prepend ServerHealthCheckRailsOsm::Patches::HealthCheck
    end

    module HealthCheck
      def initialize(*checks, logger: ServerHealthCheckRailsOsm::Logger.logger)
        super(*checks, logger: logger)
      end
    end
  end
end
