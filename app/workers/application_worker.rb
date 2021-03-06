require 'bugsnag'

class ApplicationWorker
  PR_HIGHEST = 0
  PR_CHECK_USER = 1
  PR_FETCH_ABSENCES = 75
  PR_FETCH_GRADES = 75
  PR_FETCH_DETAILED_GRADES = 100
  PR_FETCH_SCHEDULE = 25
  PR_FETCH_SESSIONS = 75

  QUEUE_REGULAR = 'regular'
  QUEUE_DETAILED_GRADES = 'grades'

  def initialize(update_id, feature_key=nil)
    @update = Update.find(update_id)
    @feature_key = feature_key
  end

  def enqueue(job)
    @update.update_attribute :state, Update::STATE_SCHEDULED
  end

  def before(job)
    @update.update_attribute :state, Update::STATE_UPDATING
  end

  def success(job)
    if @feature_key.nil? or Feature.enabled? @feature_key
      @update.update_attribute :state, Update::STATE_OK
    else
      @update.update_attribute :state, Update::STATE_DISABLED
    end
  end

  def error(job, exception)
    Bugsnag.notify exception
  end

  def failure(job)
    @update.update_attribute :state, Update::STATE_FAILED
  end

end