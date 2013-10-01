require 'resque/tasks'

task "resque:setup" => :environment do
  ENV["QUEUES"] = "critical,high,medium,low"
end

desc "Alias for resque:work (to let us imagine that we are on Heroku)"
task "jobs:work" => "resque:work"