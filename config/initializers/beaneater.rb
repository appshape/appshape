Beaneater.configure do |config|
  config.default_put_delay   = 0
  config.default_put_pri     = 65536
  config.default_put_ttr     = 120
  config.beanstalkd_url      = 'localhost:11300'
end