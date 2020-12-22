Rails.application.routes.draw do
  devise_for :users
  
  root to: "home#index"
  
  resources :items, only: [:index, :create, :new]

end
