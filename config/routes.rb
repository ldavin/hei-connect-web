HeiConnectWeb::Application.routes.draw do
  get 'dashboard/:ecampus_id' => 'dashboard#index', as: :dashboard
  get 'dashboard/:ecampus_id/courses' => 'dashboard#courses', as: :dashboard_courses
  get 'dashboard/:ecampus_id/grades/:year/:try' => 'dashboard#grades', as: :dashboard_grades
  put 'dashboard/:ecampus_id/grades/:year/:try' => 'dashboard#update_grades'
  get 'dashboard/:ecampus_id/absences/:year/:try' => 'dashboard#absences', as: :dashboard_absences
  put 'dashboard/:ecampus_id/absences/:year/:try' => 'dashboard#update_absences'

  get 'ics/:key' => 'ics#show', as: :ics

  resource :sessions, only: [:destroy]
  resource :users, only: [:create] do
    get 'validate'
  end

  get 'about' => 'welcome#about'
  get 'status' => 'welcome#status'

  namespace(:admin) {
    resources :absences
    resources :course_rooms
    resources :course_teachers
    resources :course_users
    resources :courses
    resources :grades
    resources :exams
    resources :groups
    resources :rooms
    resources :sections
    resources :teachers
    resources :updates
    resources :user_sessions
    resources :users

    post 'sessions' => 'sessions#create'
    delete 'sessions' => 'sessions#destroy'

    get 'dashboard' => 'dashboard#index'
    get 'dashboard/maintenance' => 'dashboard#switch_maintenance'

    root to: 'sessions#index'
  }

  root :to => 'welcome#index'
end
