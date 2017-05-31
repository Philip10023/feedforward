Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  devise_scope :user do
      root to: 'feeds#index'
      resources :feeds, only: [:index, :new, :show, :create]
      resources :reviews, only: [:index, :destroy]
      resources :users, except: [:new, :create]
end

  root to: 'feeds#index'
  resources :feeds, only: [:index, :show, :create, :new, :destroy]
  resources :reviews, only: [:index, :destroy]



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
