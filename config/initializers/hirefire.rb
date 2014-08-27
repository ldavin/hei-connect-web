HireFire::Resource.configure do |config|
  config.dyno(:worker_regular) do
    HireFire::Macro::Delayed::Job.queue(:regular, mapper: :active_record)
  end

  config.dyno(:worker_grades) do
    HireFire::Macro::Delayed::Job.queue(:grades, mapper: :active_record)
  end
end