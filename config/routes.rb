Rails.application.routes.draw do
  get 'cards/new'
  get 'users/show'
  get 'practices/index'
  devise_for :users
  root "practices#index"

  resources :users, only: [:show, :update]
  resources :cards, only: [:new, :create]
  resources :practices, only: :order do
    post 'apply', on: :member
  end
end
