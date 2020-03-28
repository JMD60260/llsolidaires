class UserMailer < ApplicationMailer
  # Send a mail with password to Users created with CSV
  def send_password_to_new_user(user, password)
    @user = user
    @password = password
    mail(to: @user.email,
      subject: "Les Logements Solidaires - Merci à vous! Voici votre mot de passe")
  end

end
