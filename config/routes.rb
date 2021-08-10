Rails.application.routes.draw do

  resources :airlines, only: [:show]

  resources :flights, only: [:index]
    resources :trips, only: [:destroy]
end
