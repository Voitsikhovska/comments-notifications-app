Rails.application.routes.draw do
  devise_for :users, skip: [ :passwords, :unlocks, :confirmations ]

  resources :comments, only: [:index, :create, :edit, :update, :destroy]

  get "up" => "rails/health#show", as: :rails_health_check

  root "comments#index"
end
