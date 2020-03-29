Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'


  resources :flats, only: [:index, :show, :new, :create, :destroy] do
    resources :rentals, only: [:new, :create]
  end
  resources :rentals, only: [:show, :index, :edit] do
    member { get :download_proof }
  end
  resources :dashboards, only: [:index]
  get 'dashboards/owner', to: "dashboards#owner"
  get 'dashboards/medical', to: "dashboards#medical"
  get 'pages/userProfile', to: "pages#userProfile"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
