Rails.application.routes.draw do

  resources :flights, only: [:index]

  resources :trips, only: [:destroy]
end
