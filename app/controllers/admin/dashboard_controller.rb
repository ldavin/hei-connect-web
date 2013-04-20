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

  def run_rake_task
    task = case params[:task].to_sym
             when :clean_courses
               'data:clean_courses'
             when :update_schedules
               'data:update_schedules'
             when :update_sessions
               'data:update_sessions'
             when :update_grades
               'data:update_grades'
             when :update_absences
               'data:update_absences'
             else
               nil
           end

    options = "RAILS_ENV='#{Rails.env}'"
    system "rake #{task} #{options} &"

    flash[:notice] = "Tâche #{task} lancée"
    redirect_to admin_dashboard_url
  end
end
