class RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :edit, :update, :destroy]

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
    # To access in a partial
    @rental = Rental.new
  end

  def create
    if current_user == 'medical'
      @rental = Rental.new(rental_params)
    else
      flash[:error] = "Accès interdit -> Vous devez vous inscrire d'abord !"
      redirect_to root_path
    end

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def set_rental
    @rental = Rental.find(params[:id])
  end

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :limit_date, :user_id, :flat_id)
  end
end
