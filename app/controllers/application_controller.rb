class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:role,
                         :email,
                         :password,
                         :password_confirmation,
                         :first_name,
                         :last_name,
                         :phone,
                         :rgpd,
                         :description)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
       user_params.permit(:role,
                          :email,
                          :first_name,
                          :last_name,
                          :phone,
                          :password,
                          :password_confirmation,
                          :current_password,
                          :identity_file,
                          :identity_file_cache,
                          :remove_identity_file,
                          :proof,
                          :proof_cache,
                          :remove_proof,
                          :description
                          )
    end
  end
end

