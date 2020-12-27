Rails.application.routes.draw do
  devise_for :users
  
  root to: "home#index"
  
  resources :items, only: [:create, :new, :show, :edit, :update, :destroy]

end


