web: bundle exec puma -C ./config/puma.rb
clock: clockwork clock.rb
scheduler_queue: beanstalkd -p 11305
results_queue: beanstalkd -p 11306
test_runner: subcontract --rvm 'ruby-2.2.3@appshape-runner' --chdir ../appshape-runner --signal INT -- bundle exec ruby main.rb --locations new_york,amsterdam,san_francisco,singapore,london,frankfurt,toronto
results_reporter: subcontract --rvm 'ruby-2.2.3@appshape-results-reporter' --chdir ../appshape-results-reporter --signal INT -- bundle exec ruby main.rb