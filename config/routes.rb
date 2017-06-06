Rails.application.routes.draw do
  root to: 'feeds#index'
  resources :feeds, only: [:index, :show, :create, :new, :destroy]
  resources :reviews, only: [:index, :destroy]

  namespace :api do
    namespace :v1 do
      resources :feeds, only: [:show]
      resources :reviews, only: [:create, :update]
    end
  end

  devise_for :users
  resources :users, except: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
