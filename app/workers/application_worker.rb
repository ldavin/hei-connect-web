require 'bugsnag'

module ApplicationWorker

  def after_enqueue_update_state *args
    update_object(args).update_attribute :state, Update::STATE_SCHEDULED
  end

  def before_perform_update_state *args
    update_object(args).update_attribute :state, Update::STATE_UPDATING
  end

  def after_perform_update_state *args
    update_object(args).update_attribute :state, Update::STATE_OK
  end

  def on_failure_update_state e, *args
    update_object(args).update_attribute :state, Update::STATE_FAILED
    Bugsnag.notify e
  end

end