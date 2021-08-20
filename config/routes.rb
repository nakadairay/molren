Rails.application.routes.draw do
  get 'cards/new'
  get 'users/show'
  get 'practices/index'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root "practices#index"

  resources :users, only: [:show, :update]
  resources :cards, only: [:new, :create]
  resources :practices, only: :order do
    post 'apply', on: :member
  end
end
