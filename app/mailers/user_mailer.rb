class UserMailer < ApplicationMailer
  # Send a mail with password to Users created with CSV
  def send_password_to_new_user(user, password)
    @user = user
    @password = password
    mail(to: @user.email,
         subject: "Les Logements Solidaires - Bienvenue sur la plateforme! Voici votre mot de passe"
         )
  end

  def send_rental_demand_to_owner(rental)
    @rental = rental
    @flat = rental.flat
    @owner = rental.flat.user
    mail(to: @owner.email,
         subject: "Les Logements Solidaires - Vous avez reçu une demande de réservation pour votre appartment situé #{@flat.address}"
         )
  end

  def send_acceptation_to_medical(rental)
    @rental = rental
    @flat = rental.flat
    @owner = rental.flat.user
    mail(to: @rental.user.email,
         subject: "Votre réservation pour l'appartement situé #{@flat.address} a été acceptée"
         )
  end

  def send_refusal_to_medical(rental)
    @rental = rental
    @flat = rental.flat
    mail(to: @rental.user.email,
         subject: "Votre réservation pour l'appartement situé #{@flat.address} a été refusée"
         )
  end

  def send_sos_to_llsolidaires(user)
    @user = user
    mail(to: "contact@les-logements-solidaires.com",
         subject: "SOS - Un utilisateur requiert une assistance"
        )
  end

  def send_new_flats_to_existing_user(user_mail, nb_of_new_flats)
    mail(to: user_mail,
         subject: "Les Logements Solidaires - Des appartements ont été crées pour vous (#{nb_of_new_flats}")
  end

  def send_parsing_errors_to_uploader(errors)
    mail(to: "contact@les-logements-solidaires.com",
         subject: "Vous avez implémenté la base de données avec un csv, des erreurs étaient présentes")
  end
end
