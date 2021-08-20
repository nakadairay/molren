Rails.application.routes.draw do
  get 'users/show'
  get 'practices/index'
  devise_for :users
  root "practices#index"

  resources :users, only: [:show, :update]
end
