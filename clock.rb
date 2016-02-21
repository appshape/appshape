require './config/boot'
require './config/environment'
require 'clockwork'

module Clockwork
  every(1.minute, 'appshape.tests_scheduler') do
    TestRunScheduler.new.execute
  end
end