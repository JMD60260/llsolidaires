class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if user_signed_in?
      if current_user.role == "owner"
        redirect_to dashboards_owner_path
      elsif current_user.role == "medical"
        redirect_to dashboards_medical_path
      end
    else
      redirect_to new_user_session_path
    end
  end

  def sos_mailer
    # Methode de mailer avec view de mail qui envoit un mail à nous même pour contact@les-logements-solidaires.com
    UserMailer.send_sos_to_llsolidaires(current_user).deliver
    redirect_to dashboards_path
  end

  def legal_notice
  end

  def privacy_policy
  end

  def owner_doc
  end

  def medical_doc
  end
end
