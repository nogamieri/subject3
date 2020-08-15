Rails.application.routes.draw do

  devise_for :users, controllers: {
  	sessions: 'devise/sessions',
  	registrations: 'devise/registrations'
  }

  root 'home#top'
  get 'home/about'

    resources :users,only: [:show,:index,:edit,:update]
    resources :books do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
end
