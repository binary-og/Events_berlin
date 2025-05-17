Rails.application.routes.draw do
  devise_for :users

  # Defines the root path route ("/")
   root "home#index"
   

   resources :events
   resources :users, only: [:show]
   resources :attendances, only: [:create, :destroy]
   resources :attendings, only: [:create, :destroy]
   resources :invites, only: [:create, :destroy]


end
