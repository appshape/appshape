web: bundle exec puma -C ./config/puma.rb
scheduler_queue: beanstalkd -p 11305
results_queue: beanstalkd -p 11306
clock: clockwork clock.rb
test_runner: bash -lc "cd ../appshape-runner && bundle exec ruby main.rb --locations new_york,amsterdam,san_francisco,singapore,london,frankfurt,toronto"
results_reporter: bash -lc "cd ../appshape-results-reporter && bundle exec ruby main.rb"