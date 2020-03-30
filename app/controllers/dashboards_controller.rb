class DashboardsController < ApplicationController

  def owner
    @flats = current_user.flats
    @flat = Flat.new
  end

  def medical
     @flats = Flat.where("address ILIKE ?", "%#{params[:query]}%")
     if params[:query]

        @start_date = Date.parse(params[:start])
        if params[:end] == ""
          @end_date = nil
        else
          @end_date = Date.parse(params[:end])
        end

      puts "je suis dans le if"
      @flats = Flat.near(params[:query], 20)
    else
      puts "je suis dans le else"
      @flats = Flat.all
    end
    @markers = geocoded_flats
  end
    # raise

  private

  def geocoded_flats
    @flats.map do |flat|
      {
        lat: flat.geocode[0],
        lng: flat.geocode[1],
        # infoWindow: { content: render_to_string(partial: "/flats/maps", locals: { flat: flat }) }
      }
    end
  end
end
