class DashboardsController < ApplicationController

  def owner
    @flats = current_user.flats
    @flat = Flat.new
  end

def medical
     @flats = Flat.where("address ILIKE ?", "%#{params[:query]}%")
     if params[:query]
      puts "je suis dans le if"
      @flats = Flat.near(params[:query], 20)
      @markers = @flats.map do |flat|
        {
          lat: flat.geocode[0],
          lng: flat.geocode[1],
          # infoWindow: { content: render_to_string(partial: "/flats/maps", locals: { flat: flat }) }
        }
      end
    else
      puts "je suis dans le else"
      @flats = Flat.all
      @markers = @flats.map do |flat|
        {
          lat: flat.geocode[0],
          lng: flat.geocode[1],
          # infoWindow: { content: render_to_string(partial: "/flats/maps", locals: { flat: flat }) }
        }
      end
    end
  end
    # raise

end
