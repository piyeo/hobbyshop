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
  resources :orders, only: [:new, :create,:index, :show,:update]
  resource :account, only: [:show, :edit, :update]
  resource :cart do
    get "add", on: :member #カートの追加
  end

  namespace :admin do
    root "top#index"
    resources :items
    resources :orders
    post 'items/new' => 'items#create'
    patch 'items/:id/edit' => 'items#update'
  end
end
