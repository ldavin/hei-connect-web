module ApplicationHelper

  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      # Skip Devise :timeout and :timedout flags
      next if type == :timeout
      next if type == :timedout
      type = :success if type == :notice
      type = :danger if type == :alert
      text = content_tag(:div, message, class: "alert alert-#{type}")
      flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end

end
