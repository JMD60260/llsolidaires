class RentalsController < ApplicationController
  before_action :set_rental, only: [:download_proof, :edit, :update, :destroy]

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
        redirect_to medical_pending_requests_path
      else
        redirect_to root_path
      end
    else
      flash[:error] = "Vous ne pouvez pas réserver d'appartement avant de vous être inscrit en tant que personnel soignant."
      redirect_to root_path
    end
  end

  def destroy
    if current_user == @rental.user
      if @rental.validated == false
        @rental.destroy
        flash[:error] = "Vous avez supprimé la demande de réservation de l'appartement situé au #{@rental.flat.address}"
        redirect_to medical_pending_requests_path
      elsif @rental.start_date > Date.today
        @rental.destroy
        flash[:error] = "Vous avez annulé votre réservation de l'appartement situé au #{@rental.flat.address}"
        redirect_to medical_validated_rentals_path
      elsif !(@rental.end_date) || @rental.end_date >= Date.today
        @rental.update(end_date: Date.today)
        flash[:error] = "Vous avez mis fin à votre occupation de l'appartement situé au #{@rental.flat.address}, à compter d'aujourd'hui."
        redirect_to medical_validated_rentals_path
      end
    else
      flash[:error] = "Vous ne pouvez pas supprimer cette réservation."
      redirect_to root_path
    end
  end

  def validate_rental
    # Supprimer toutes les autres rentals.validated == false pour le @rental.user, seuleùent celles qui ont une date en commun avec @rental
    @rental = Rental.find(params[:rental_id])
    if @rental.flat.user == current_user && @rental.validated == false
      @rental.update(validated: true)
      @flat_rentals = @rental.flat.rentals
      @rentals_to_delete = []
      @flat_rentals.each do |rental|
        if @rental.end_date != nil && (@rental.start_date..@rental.end_date).include?(rental.start_date)
          @rentals_to_delete << rental
        elsif rental.start_date <= @rental.start_date
          @rentals_to_delete << rental
        end
      end
      UserMailer.send_acceptation_to_medical(@rental).deliver
      refuse_rental_to_delete(@rentals_to_delete)
      redirect_to owner_pending_requests_path
    else
      flash[:error] = "Vous ne pouvez pas valider cette réservation."
    end
  end

  def refuse_rental
    @rental = Rental.find(params[:rental_id])
    if @rental.flat.user == current_user && @rental.validated == false
      flash[:error] = "Vous avez refusé la réservation de l'appartement situé #{@rental.flat.address} par #{@rental.user.first_name} #{@rental.user.last_name}"
      @rental.destroy
      UserMailer.send_refusal_to_medical(@rental).deliver
      redirect_to owner_pending_requests_path
    else
      flash[:error] = "Vous ne pouvez pas refuser cette réservation."
    end
  end

  def owner_validated
    @tab = "Réservations"
    @as = "owner"
    # Les rentals du current owner, validated==true, a trier par "en cours" et "a venir" (du plus récent au plus vieux), (contendra partial show)
    @current_rentals = []
    @future_rentals = []
    current_user.flats.each do |flat|
      flat.rentals.each do |rental|
        if rental.validated
          if rental.start_date > Date.today
            @future_rentals << rental
          elsif rental.start_date <= Date.today && (!rental.end_date || rental.end_date >= Date.today)
            @current_rentals << rental
          end
        end
      end
    end
    @current_rentals.sort_by{ |rental| rental.end_date }
    @future_rentals.sort_by{ |rental| rental.start_date }
  end

  def owner_pending
    @tab = "Demandes"
    @as = "owner"
    # Les rentals du current_owner, validated==false, a trier par date de début, (contiendra boutons valider et refuse + partial rental show)
    @rentals = []
    @rentals
    current_user.flats.each do |flat|
      flat.rentals.each do |rental|
        if !rental.validated && (!rental.end_date || rental.end_date >= Date.tomorrow)
          @rentals << rental
        end
      end
    end
    @rentals.sort_by{ |rental| rental.start_date }

  end

  def medical_validated
    @tab = "Mes réservations"
    @as = "medical"
    # Les rentals du current medical, validated==true, celles en cours et dans le futur
    if current_user.role == 'medical'
       # all_rentals_from_medic = Rental.joins(:flat).where(user: current_user)
       @current_rentals = current_user.rentals.where(validated: true).select {|rental| rental.start_date <= Date.today && (!rental.end_date || rental.end_date >= Date.today) }.sort_by{ |rental| rental.end_date }
       @future_rentals = current_user.rentals.where(validated: true).select {|rental| rental.start_date > Date.today }.sort_by{ |rental| rental.start_date }
    else
      flash[:error] = "Vous n'avez pas accés à cette page.'"
      redirect_to root_path
    end
  end

  def medical_pending
    @tab = "Demandes"
    @as = "medical"
    # Les rentals du current medical, validated==false, celles à venir seulement
    if current_user.role == 'medical'
       # all_rentals_from_medic = Rental.joins(:flat).where(user: current_user)
       @rentals = current_user.rentals.where(validated: false).select { |rental| (!rental.end_date || rental.end_date >= Date.tomorrow) }.sort_by{ |rental| rental.start_date }
    else
      flash[:error] = "Vous n'avez pas accés à cette page.'"
      redirect_to root_path
    end
  end
  
  def index
    displayable_attributes = [:flat_id, :user_id, :validated, :start_date, :end_date]
    @rental = Rental.all

    respond_to do |format|
      format.csv do
        csv_stream_headers(filename: "#{Time.now.strftime("%Y%m%d-%H%M%S")}_rentals.csv")
        self.response_body = CsvExport.new(@rental, displayable_attributes).perform
      end
      format.html
    end
  end

  private

  def refuse_rental_to_delete(rentals_to_delete)
    rentals_to_delete.each do |rental|
      if rental.flat.user == current_user && rental.validated == false
        flash[:error] = "Vous avez refusé la réservation de l'appartement situé #{rental.flat.address} par #{rental.user.first_name} #{rental.user.last_name}, du #{rental.start_date} au #{rental.end_date.nil? ? "Date non définie" : rental.end_date}"
        rental.destroy
        UserMailer.send_refusal_to_medical(rental).deliver
      end
    end
  end

  def set_rental
    @rental = Rental.find(params[:id])
  end

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :limit_date, :user_id, :flat_id)
  end
end
