Rails.application.routes.draw do
  get 'cards/new'
  get 'users/show'
  get 'practices/index'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root "practices#index"

  resources :users, only: [:new, :show, :update]
  resources :cards, only: [:new, :create]
  resources :practices do
    member do
      post 'apply'
      get "csv_practice_user"
    end
    collection do
      get 'completion'
    end
  end
end
