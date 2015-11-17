Aws.config.update({
  region: ENV['AWS_REGION_FOR_CACHE'],
  credentials: Aws::Credentials.new(
      ENV['AWS_ACCESS_KEY_ID'],
      ENV['AWS_SECRET_ACCESS_KEY']),
})
