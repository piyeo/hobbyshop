Rails.application.routes.draw do
  root 'items#index'

  get  '/signup' => 'users#new'

  resources :items
end
