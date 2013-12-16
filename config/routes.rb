HeiConnectWeb::Application.routes.draw do
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

  namespace(:admin) {
    get 'entity/:entity(.:format)' => 'entity#index', as: :entities
    post 'entity/:entity(.:format)' => 'entity#create'
    get 'entity/:entity/new(.:format)' => 'entity#new', as: :new_entity
    get 'entity/:entity/:id/edit(.:format)' => 'entity#edit', as: :edit_entity
    get 'entity/:entity/:id(.:format)' => 'entity#show', as: :entity
    put 'entity/:entity/:id(.:format)' => 'entity#update'
    delete 'entity/:entity/:id(.:format)' => 'entity#destroy'

    post 'sessions' => 'sessions#create'
    delete 'sessions' => 'sessions#destroy'

    get 'dashboard' => 'dashboard#index'
    get 'dashboard/maintenance' => 'dashboard#switch_maintenance'
    post 'dashboard/task/:task' => 'dashboard#run_rake_task', as: :run_task

    root to: 'sessions#index'
  }

  root :to => 'welcome#index'
end
