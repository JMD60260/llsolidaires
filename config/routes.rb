Rails.application.routes.draw do



  resources :dashboards, only: [:index]
  get 'dashboards/owner', to: "dashboards#owner"
  get 'dashboards/medical', to: "dashboards#medical"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users
  root to: 'pages#home'
end
