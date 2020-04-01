class DashboardsController < ApplicationController

  def owner
    @tab = "Mes logements"
    @as = "owner"
    @flats = current_user.flats
    @flat = Flat.new
  end

  def medical
    if current_user.role == "medical"
      @tab = "Recherche de logements"
      @as = "medical"
      if params[:query]
        @query = true
        @start_date = Date.parse(params[:start])
        if params[:end] == ""
          @end_date = nil
        else
          @end_date = Date.parse(params[:end])
        end
        @flats = Flat.near([params[:lat], params[:lng]], 5)
        # @flats = Flat.near([params[:lat], params[:lng]], 5).select { |flat| flat.available_for(@start_date, @end_date) }
        @flats = Flat.all
      else
        @query = false
        @flats = Flat.all
      end
      @markers = geocoded_flats(@flats)
    else
      flash[:error] = "Vous n'avez pas accés à cette page.'"
      redirect_to root_path
    end
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

  def owner_profile
    redirect_to edit_user_registration_path(as: 'owner')
  end

  def medical_profile
    redirect_to edit_user_registration_path(as: 'medical')
  end

  private

  def geocoded_flats(flats)
    flats.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
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
