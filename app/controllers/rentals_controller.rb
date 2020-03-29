class RentalsController < ApplicationController
  before_action :set_rental, only: [:download_proof, :edit, :update, :destroy, :validate_rental, :refuse_rental]

  def download_proof
    data = open(@rental.user.proof.url)
    extension_rgx = /[0-9a-z]+$/
    send_data data.read, type: data.content_type, x_sendflile: true, filename: "justificatif_#{@rental.user.last_name}_#{@rental.user.first_name}.#{(@rental.user.proof.path).match(extension_rgx).to_s}"
  end

  def create
    if current_user.role == 'medical'
      @rental = Rental.new(rental_params)
      if @rental.save
        UserMailer.send_rental_demand_to_owner(@rental).deliver
        redirect_to root_path
      else
        render :new
      end
    else
      flash[:error] = "Vous ne pouvez pas réserver d'appartement avant de vous être inscrit en tant que personnel soignant."
      redirect_to root_path
    end
  end

  def destroy
    if current_user == @rental.user && @rental.validated == false
      flash[:error] = "Vous avez supprimé la demande de réservation de l'appartement situé #{@rental.flat.address}"
      @rental.destoy
      redirect_to root_path
    else
      flash[:error] = "Vous ne pouvez pas supprimer cette réservation."
      redirect_to root_path
    end
  end

  def validate_rental
    if @rental.flat.user == current_user && @rental.validated == false
      @rental.update(validated: true)
      # Supprimer toutes les autres rentals.validated == false pour le @rental.user, seuleùent celles qui ont une date en commun avec @rental
      UserMailer.send_acceptation_to_medical(@rental).deliver
      render :owner_validated
    else
      flash[:error] = "Vous ne pouvez pas valider cette réservation."
    end
  end

  def refuse_rental
    # Display une pop up demandant validation de la part de l'utilisateur
    if @rental.flat.user == current_user && @rental.validated == false
      flash[:error] = "Vous avez refusé la réservation de l'appartement situé #{@rental.flat.address} par #{@rental.user.first_name} #{@rental.user.last_name}"
      @rental.destroy
      UserMailer.send_refusal_to_medical(@rental).deliver
      redirect_to root_path
    else
      flash[:error] = "Vous ne pouvez pas refuser cette réservation."
    end
  end

  def owner_validated
    # Les rentals du current owner, validated==true, a trier par "en cours" et "a venir" (du plus récent au plus vieux), (contendra partial show)
    if current_user.role == "owner"
      @current_rentals = []
      @future_rentals = []
      current_user.flats.each do |flat|
        flat.rentals.each do |rental|
          if rental.validated
            if rental.start_date > Date.today
              @future_rentals << rental
            elsif rental.start_date <= Date.today && rental.end_date >= Date.today
              @current_rentals << rental
            end
          end
        end
      end
      @current_rentals.sort_by{ |rental| rental.end_date }
      @future_rentals.sort_by{ |rental| rental.start_date }
    else
      flash[:error] = "Vous n'avez pas accés à cette page.'"
      redirect_to root_path
    end
  end

  def owner_pending
    # Les rentals du current_owner, validated==false, a trier par date de début, (contiendra boutons valider et refuse + partial rental show)
    if current_user.role == "owner"
      @rentals = []
      @rentals
      current_user.flats.each do |flat|
        flat.rentals.each do |rental|
          if !rental.validated && rental.end_date >= Date.tomorrow
            @rentals << rental
          end
        end
      end
      @rentals.sort_by{ |rental| rental.start_date }
    else
      flash[:error] = "Vous n'avez pas accés à cette page.'"
      redirect_to root_path
    end
  end

  def medical_validated
    # Les rentals du current medical, validated==true, celles en cours et dans le futur
    if current_user.role == 'medical'
       # all_rentals_from_medic = Rental.joins(:flat).where(user: current_user)
       @current_rentals = current_user.rentals.where(validated: true).select {|rental| rental.start_date <= Date.today && rental.end_date >= Date.today }.sort_by{ |rental| rental.end_date }
       @future_rentals = current_user.rentals.where(validated: true).select {|rental| rental.start_date > Date.today }.sort_by{ |rental| rental.start_date }
    else
      flash[:error] = "Vous n'avez pas accés à cette page.'"
      redirect_to root_path
    end
  end

  def medical_pending
    # Les rentals du current medical, validated==false, celles à venir seulement
    if current_user.role == 'medical'
       # all_rentals_from_medic = Rental.joins(:flat).where(user: current_user)
       @rentals = current_user.rentals.where(validated: false).select { |rental| rental.end_date >= Date.tomorrow }.sort_by{ |rental| rental.start_date }
    else
      flash[:error] = "Vous n'avez pas accés à cette page.'"
      redirect_to root_path
    end
  end

  private

  def set_rental
    @rental = Rental.find(params[:id])
  end

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :limit_date, :user_id, :flat_id)
  end
end
