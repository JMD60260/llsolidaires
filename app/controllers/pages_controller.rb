class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :legal_notice, :privacy_policy, :about_us, :partners]

  def home
    if user_signed_in?
      if current_user.role == "owner"
        redirect_to dashboard_owner_path
      elsif current_user.role == "medical"
        redirect_to dashboard_medical_path
      end
    else
      redirect_to new_user_session_path
    end
  end

  def sos_mailer
    UserMailer.send_sos_to_llsolidaires(current_user).deliver
    redirect_to dashboards_path
  end

  def legal_notice
  end

  def privacy_policy
  end

  def about_us
  end

  def partners
  end

  def owner_doc
    @tab = "Aide et documentation"
    @as = "owner"
  end

  def medical_doc
    @tab = "Aide et documentation"
    @as = "medical"
  end
end
