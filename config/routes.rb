Rails.application.routes.draw do
  devise_for :users
  
  root to: "home#index"
  
  resources :items, only: [:create, :new, :show, :edit, :update, :destroy]
  resources :items do
    resources :purchase_records, only: [:create, :index]
  end

end


