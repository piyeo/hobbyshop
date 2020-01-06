Rails.application.routes.draw do
  root 'items#index'

  get  '/signup' => 'users#new'
  post  '/signup' => 'users#create'
  get    '/login' => 'sessions#new'
  post   '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get    '/login_admin' => 'admins#new'
  post   '/login_admin' => 'admins#create'
  delete '/logout_admin' => 'admins#destroy'

  resources :items, only: [:index, :show]
  resources :users
  resource :account, only: [:show, :edit, :update]

  namespace :admin do
    root "top#index"
    resources :items
    post 'items/new' => 'items#create'
    patch 'items/:id/edit' => 'items#update'
  end
end
