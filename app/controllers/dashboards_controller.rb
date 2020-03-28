class DashboardsController < ApplicationController

  def owner
    @flats = Flat.all
    @own_flats = current_user.flats
    @own_rentals = current_user.rentals
  end

  def medical
     @flats = Flat.where("address ILIKE ?", "%#{params[:query]}%")
      @markers = @flats.map do |flat|
        {
          lat: flat.latitude,
          lng: flat.longitude,
          # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
        }
      end
  end

  def show
    set_flat
  end
private

  def set_flat
    @flat = Flat.find(params[:id])
  end

  def flat_params
    params.require(:flat).permit(:address, :flat_type, :description, :accessibility_pmr)
  end

end
