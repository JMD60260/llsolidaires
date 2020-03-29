class UserMailer < ApplicationMailer
  # Send a mail with password to Users created with CSV
  def send_password_to_new_user(user, password)
    @user = user
    @password = password
    mail(to: @user.email,
         subject: "Les Logements Solidaires - Merci à vous! Voici votre mot de passe"
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
         subject: "Votre réservation pour l'appartement situé #{@flat.address} a été acceptée."
         )
  end

  def send_refusal_to_medical(rental)
    @rental = rental
    @flat = rental.flat
    mail(to: @rental.user.email,
         subject: "Votre réservation pour l'appartement situé #{@flat.address} a été refusée."
         )
  end

  def send_sos_to_llsolidaires(user)
    @user = user
    mail(to: "contact@les-logements-solidaires.com",
         subject: "Un utilisateur vient de cliquer sur SOS"
        )
  end
end
