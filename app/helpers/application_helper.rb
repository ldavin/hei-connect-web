module ApplicationHelper
  def public_nav_link(text, link)
    recognized = Rails.application.routes.recognize_path link
    if recognized[:controller] == params[:controller] && recognized[:action] == params[:action]
      content_tag :li, :class => "active" do
        link_to text, link
      end
    else
      content_tag :li do
        link_to text, link
      end
    end
  end

  def app_nav_link(text, icon, link)
    recognized = Rails.application.routes.recognize_path link
    if recognized[:controller] == params[:controller] && recognized[:action] == params[:action]
      content_tag :li, class: "active" do
        link_to raw(content_tag(:i, nil, class: "icon-#{icon}") + text), link
      end
    else
      content_tag :li do
        link_to raw(content_tag(:i, nil, class: "icon-#{icon}") + text), link
      end
    end
  end

  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      # Skip Devise :timeout and :timedout flags
      next if type == :timeout
      next if type == :timedout
      type = :success if type == :notice
      type = :error if type == :alert
      text = content_tag(:div,
                         content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") +
                             message, :class => "alert fade in alert-#{type}")
      flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end
end
