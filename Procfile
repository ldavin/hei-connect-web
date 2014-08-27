web: bundle exec puma -C config/puma.rb
worker_regular: QUEUES=regular bundle exec rake jobs:work
worker_grades: QUEUES=grades bundle exec rake jobs:work