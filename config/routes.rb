Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get 'pages/legal-notice', to: "pages#legal_notice"
  get 'pages/privacy-policy', to: "pages#privacy_policy"
  get 'pages/owner-doc', to: "pages#owner_doc"
  get 'pages/medical-doc', to: "pages#medical_doc"
  get 'pages/sos_mailer', to: "pages#sos_mailer"

  get 'dashboard/owner', to: "dashboards#owner"
  get 'dashboard/medical', to: "dashboards#medical"

  resources :flats do
    resources :rentals, only: [:new, :create]
  end
  resources :rentals, only: [:show, :index, :edit] do
    member { get :download_proof }
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
