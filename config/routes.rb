HeiConnectWeb::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  get 'dashboard/:ecampus_id' => 'dashboard#index', as: :dashboard
  get 'dashboard/:ecampus_id/courses' => 'dashboard#courses', as: :dashboard_courses
  get 'dashboard/:ecampus_id/grades/:year/:try' => 'dashboard#grades', as: :dashboard_grades
  put 'dashboard/:ecampus_id/grades/:year/:try' => 'dashboard#update_grades'
  get 'dashboard/:ecampus_id/absences/:year/:try' => 'dashboard#absences', as: :dashboard_absences

  get 'ics/:key' => 'ics#show', as: :ics

  resource :sessions, only: [:destroy]
  resource :users, only: [:create] do
    get 'validate'
  end

  get 'about' => 'welcome#about'
  get 'status' => 'welcome#status'

  root :to => 'welcome#index'
end
