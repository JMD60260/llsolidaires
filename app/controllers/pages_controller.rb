class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
   if user_signed_in?
      if current_user.role == "owner"
        # ICI REMPLACER "redirect_to root_path" PAR LA ROUTE VERS DASHBOARD PROPRIETAIRES
        redirect_to dashboards_owner_path
      elsif current_user.role == "medical"
        # ICI REMPLACER "redirect_to root_path" PAR LA ROUTE VERS DASHBOARD PERSONNEL SOIGNANT
        redirect_to dashboards_medical_path
      end
    end
  end

  def sos_mailer
    # Methode de mailer avec view de mail qui envoit un mail à nous même pour contact@les-logements-solidaires.com
    UserMailer.send_sos_to_llsolidaires(current_user).deliver
    redirect_to dashboards_path
  end

  def userProfile
  end
end
