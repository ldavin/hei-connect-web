Delayed::Worker.destroy_failed_jobs = true
Delayed::Worker.sleep_delay = 5
Delayed::Worker.max_attempts = 2
Delayed::Worker.max_run_time = 5.minutes
Delayed::Worker.read_ahead = 5