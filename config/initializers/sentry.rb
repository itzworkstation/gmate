Sentry.init do |config|
  config.dsn = 'https://8ff501dadeaca0873211edce975f55b0@o4506972592799744.ingest.us.sentry.io/4506972595159040'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end