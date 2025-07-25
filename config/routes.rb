# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  # Defines the root path route ("/")
  root 'home#index'

  resources :events
  resources :users, only: [:show]
  resources :attendances, only: %i[create destroy]
  resources :attendings, only: %i[create destroy]
  resources :invites, only: %i[create destroy]
end
