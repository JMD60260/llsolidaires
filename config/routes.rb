Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'


  resources :flats, only: [:index, :show, :new, :create, :destroy] do
    resources :rentals, only: [:show, :create]
  end
  resources :rentals, only: [:index, :edit]
  resources :dashboards, only: [:index]
  get 'dashboards/owner', to: "dashboards#owner"
  get 'dashboards/medical', to: "dashboards#medical"
  get 'pages/userProfile', to: "pages#userProfile"

  get 'pages/sos_mailer', to: "pages#sos_mailer"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
