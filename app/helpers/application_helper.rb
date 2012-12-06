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
end
