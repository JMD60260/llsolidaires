class RentalsController < ApplicationController
  before_action :set_rental, only: [:download_proof, :show, :edit, :update, :destroy, :validate_rental, :refuse_rental]

  def download_proof
    data = open(@rental.user.proof.url)
    extension_rgx = /[0-9a-z]+$/
    send_data data.read, type: data.content_type, x_sendflile: true, filename: "justificatif_#{@rental.user.last_name}_#{@rental.user.first_name}.#{(@rental.user.proof.path).match(extension_rgx).to_s}"
  end

  def show

  end

  def index
   if current_user.role == 'owner'
      # Find the current user flats
      @flats = Flat.where(user: current_user)
      # Instanciate an empty array of rentals record
      @rentals = []
      # Iterate over current user 's flats to find the corresponding rentals
      @flats.each do |flat|
        # Store each flat's rentals
        flat_rentals = Rental.where(flat: flat)
        # Iterate over these to store it in the @rentals variable
        flat_rentals.each do |rental|
          @rentals << rental
        end
      end
    else # elsif current_user.role == 'owner'
      @rentals = Rental.where(user: current_user)
    end
  end

  def new
    @rental = Rental.new
  end

  def create
    if current_user == 'medical'
      @rental = Rental.new(rental_params)
      if @rental.save
        UserMailer.send_rental_demand_to_owner(@rental).deliver
        # On a une view rental? ou bien rediriger vers l'index de rentals du current medical
        redirect_to root_path
      else
        render :new
      end
    else
      flash[:error] = "Vous ne pouvez pas réserver d'appartement avant de vous être inscrit."
      redirect_to root_path
    end
  end

  def edit
    # a implementer si besoin?
  end

  def update
    if @rental.update(rental_params)
      # On a une view rental? ou bien rediriger vers l'index de rentals du current medical
      redirect_to rental_path(@rental)
    else
      render :edit
    end
    redirect_to root_path
  end

  def destroy
    flash[:error] = "Vous avez supprimé la réservation de l'appartement situé #{@rental.flat.address}"
    @rental.destoy
    redirect_to root_path
  end

  def validate_rental
    @rental.validated = true
    UserMailer.send_acceptation_to_medical(@rental).deliver
    # On a une view rental? ou bien rediriger vers l'index de rentals du current medical
    redirect_to rental_path(@rental)
  end

  def refuse_rental
    # Display un alerte avant validation
    flash[:error] = "Vous avez refusé la réservation de l'appartement situé #{@rental.flat.address} par #{@rental.user.first_name} #{@rental.user.last_name}"
    @rental.destroy
    UserMailer.send_refusal_to_medical(@rental).deliver
    redirect_to root_path
  end

  private

  def set_rental
    @rental = Rental.find(params[:id])
  end

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :limit_date, :user_id, :flat_id)
  end
end
