Myapp::Application.routes.draw do
  resource :sessions, only: [:new, :create, :destroy]
  resource :users, only: [:new, :create]

  root :to => 'welcome#index'
end
