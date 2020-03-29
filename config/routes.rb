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

  resources :flats, only: [:create, :edit, :update, :destroy]

  resources :rentals, only: [:create, :destroy] do
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
