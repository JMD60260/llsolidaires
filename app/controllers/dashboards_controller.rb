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
      @flats = Flat.near(params[:query], 20)
      @markers = @flats.map do |flat|
        {
          lat: flat.latitude,
          lng: flat.longitude,
          # infoWindow: { content: render_to_string(partial: "/flats/maps", locals: { flat: flat }) }
        }
      end
    end
    # raise
  end

end
