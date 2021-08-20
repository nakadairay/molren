Rails.application.routes.draw do
  get 'practices/index'
  devise_for :users
  root "practices#index"
end
