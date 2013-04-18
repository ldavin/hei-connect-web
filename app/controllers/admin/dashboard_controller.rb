# encoding: utf-8

class Admin::DashboardController < AdminController
  def index

  end

  def switch_maintenance
    if Rails.cache.read 'maintenance'
      Rails.cache.write 'maintenance', nil
    else
      Rails.cache.write 'maintenance', true
    end

    redirect_to admin_dashboard_url
  end
end
