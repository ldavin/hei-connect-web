HeiConnectWeb::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'dashboard/:ecampus_id' => 'dashboard#index', as: :dashboard
  get 'dashboard/:ecampus_id/courses' => 'dashboard#courses', as: :dashboard_courses
  get 'dashboard/:ecampus_id/grades/:year/:try' => 'dashboard#grades', as: :dashboard_grades
  put 'dashboard/:ecampus_id/grades/:year/:try' => 'dashboard#update_grades'
  get 'dashboard/:ecampus_id/absences/:year/:try' => 'dashboard#absences', as: :dashboard_absences
  put 'dashboard/:ecampus_id/absences/:year/:try' => 'dashboard#update_absences'

  get 'ics/:key' => 'ics#show', as: :ics

  resource :sessions, only: [:destroy]
  # Should be improved
  get 'sessions' => 'sessions#destroy' if Rails.env.test?

  resource :users, only: [:create] do
    get 'validate'
  end

  get 'about' => 'welcome#about'
  get 'status' => 'welcome#status'

  root :to => 'welcome#index'
end
