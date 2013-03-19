HeiConnectWeb::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  get 'dashboard' => 'dashboard#index'
  get 'dashboard/courses' => 'dashboard#courses'

  get "ics/:key" => 'ics#show', as: :ics

  resource :sessions, only: [:destroy]
  resource :users, only: [:create] do
    get 'validate'
  end

  get 'about' => 'welcome#about'

  root :to => 'welcome#index'
end
