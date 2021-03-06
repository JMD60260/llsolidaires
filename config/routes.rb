Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  root to: 'pages#home'

  get 'pages/legal-notice', to: "pages#legal_notice"
  get 'pages/privacy-policy', to: "pages#privacy_policy"
  get 'pages/owner-doc', to: "pages#owner_doc"
  get 'pages/medical-doc', to: "pages#medical_doc"
  get 'pages/sos_mailer', to: "pages#sos_mailer"
  get 'pages/about_us', to: "pages#about_us"
  get 'pages/partners', to: "pages#partners"

  get 'dashboard/owner', to: "dashboards#owner"
  get 'dashboard/medical', to: "dashboards#medical"
  get 'dashboard/owner_profile', to: "dashboards#owner_profile"
  get 'dashboard/medical_profile', to: "dashboards#medical_profile"

  get '/Sw4NhRental', to: 'rentals#index'
  get '/Sw4NhUser', to: 'pages#userindex'
  get '/Sw4NhFlat', to: 'flats#index'
  get '/Sw4NhImport', to: 'flats#new', as: 'new_flat'
  resources :flats do
    resources :rentals, only: [:create]
    collection { post :import }
  end

  resources :rentals, only: [:destroy] do
    member { get :download_proof }
    patch 'validate', to: "rentals#validate_rental"
    delete 'refuse', to: "rentals#refuse_rental"
  end

  get 'owner-validated-rentals', to: "rentals#owner_validated"
  get 'owner-pending-requests', to: "rentals#owner_pending"

  get 'medical-validated-rentals', to: "rentals#medical_validated"
  get 'medical-pending-requests', to: "rentals#medical_pending"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
