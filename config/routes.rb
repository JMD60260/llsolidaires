Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :flats do
    resources :rentals, only: [:new, :create]
  end
  resources :rentals, only: [:show, :index, :edit] do
    member { get :download_proof }
  end
  resources :dashboards, only: [:index]
  get 'dashboards/owner', to: "dashboards#owner"
  get 'dashboards/medical', to: "dashboards#medical"
  get 'pages/userProfile', to: "pages#userProfile"
<<<<<<< HEAD

  get 'pages/sos_mailer', to: "pages#sos_mailer"

=======
  get 'pages/helpDoc', to: "pages#helpDoc"
>>>>>>> c0bd03ca98c267db7d4bdf9412b24194bcc33a77
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
