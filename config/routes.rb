Myapp::Application.routes.draw do
  get 'dashboard' => 'dashboard#index'
  get 'dashboard/courses' => 'dashboard#courses'

  resource :sessions, only: [:destroy]
  resource :users, only: [:new, :create] do
    get 'validate'
  end

  root :to => 'welcome#index'
end
