class PagesController < ApplicationController
  include FileHeaders
  skip_before_action :authenticate_user!, only: [:home, :legal_notice, :privacy_policy, :about_us, :partners, :userindex]

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
    @medics_without_proof_1 = User.where(role: "medical", proof: nil)
    @medics_without_id_1 = User.where(role: "medical", identity_file: nil)
    @medics_without_both = User.where(role: "medical", identity_file: nil, proof: nil)
    @medics_without_proof_2 = @medics_without_proof_1 - @medics_without_both
    @medics_without_id_2 = @medics_without_id_1 - @medics_without_both
  end

  def owner_doc
    @tab = "Aide et documentation"
    @as = "owner"
  end

  def medical_doc
    @tab = "Aide et documentation"
    @as = "medical"
  end

  def userindex
    displayable_attributes = [:id, :email, :last_name, :first_name, :phone, :role]
    @users = User.all

    respond_to do |format|
      format.csv do
        csv_stream_headers(filename: "#{Time.now.strftime("%Y%m%d-%H%M%S")}_users.csv")
        self.response_body = CsvExport.new(@users, displayable_attributes).perform
      end
      format.html
    end
  end
end
