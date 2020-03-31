class DashboardsController < ApplicationController

  def owner
    @flats = current_user.flats
    @flat = Flat.new
  end

  def medical
    if params[:query]
      @start_date = Date.parse(params[:start])
      if params[:end] == ""
        @end_date = nil
      else
        @end_date = Date.parse(params[:end])
      end
      @flats = Flat.near(params[:query], 20)
    else
      @flats = Flat.all
    end
    @markers = geocoded_flats(@flats)
  end

  # Ancienne méthode qui envoie une 500 sans query (avec la private method)
  # def medical
  #   @flats = Flat.where("address ILIKE ?", "%#{params[:query]}%")
  #   if params[:query]
  #     @start_date = Date.parse(params[:start])
  #     if params[:end] == ""
  #       @end_date = nil
  #     else
  #       @end_date = Date.parse(params[:end])
  #     end
  #     @flats = Flat.near(params[:query], 20)
  #   else
  #     @flats = Flat.all
  #   end
  #   @markers = geocoded_flats
  # end

  private

  def geocoded_flats(flats)
    flats.map do |flat|
      {
        lat: flat.geocode[0],
        lng: flat.geocode[1]
        # infoWindow: { content: render_to_string(partial: "/flats/maps", locals: { flat: flat }) }
      }
    end
  end

  # def geocoded_flats
  #   @flats.map do |flat|
  #     {
  #       lat: flat.geocode[0],
  #       lng: flat.geocode[1]
  #       # infoWindow: { content: render_to_string(partial: "/flats/maps", locals: { flat: flat }) }
  #     }
  #   end
  # end
end

