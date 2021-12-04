# frozen_string_literal: true
config_file = Rails.root.join("config/sentry.yml")

if File.exists?(config_file)
  Sentry.init do |config|
    config.dsn = YAML::load(File.open(config_file))[Rails.env]["dns"]
    config.breadcrumbs_logger = [:active_support_logger, :http_logger]
    # config.enabled_environments = %w[production development test]

    # Set tracesSampleRate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    # We recommend adjusting this value in production
    config.traces_sample_rate = 0.5
    # or
    config.traces_sampler = lambda do |context|
      true
    end
  end
end
