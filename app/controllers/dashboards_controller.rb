class DashboardsController < ApplicationController

  def owner
    @flats = current_user.flats
    @flat = Flat.new
  end

def medical
     @flats = Flat.all
     @geo = @flats.geocoded
     if params[:query]
      puts "je suis dans le if"
      # @flatsAll = Flat.where("address ILIKE ?", "%#{params[:query]}%")
      @flats = Flat.near(params[:query], 20)
      @markers = @flats.map do |flat|
        {
          lat: flat.latitude,
          lng: flat.longitude,
          # infoWindow: { content: render_to_string(partial: "/flats/maps", locals: { flat: flat }) }
        }
      end
    else
      puts "je suis dans le else"
      @markers = @flats.map do |flat|
        {
          lat: flat.latitude,
          lng: flat.longitude,
          # infoWindow: { content: render_to_string(partial: "/flats/maps", locals: { flat: flat }) }
        }
      end
    end
  end
    # raise

end
