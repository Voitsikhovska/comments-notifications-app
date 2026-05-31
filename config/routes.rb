Rails.application.routes.draw do
  devise_for :users, skip: [ :passwords, :unlocks, :confirmations ]

  resources :comments, only: [ :index, :create, :edit, :update, :destroy ]

  resources :notifications, only: [ :index, :update ] do
    collection do
      patch :mark_all_read
    end
  end

  get "users/search", to: "users#search"

  get "up" => "rails/health#show", as: :rails_health_check

  root "comments#index"
end
