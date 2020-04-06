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
        # @flats = Flat.near([params[:lat], params[:lng]], 20).first(30).select { |flat| flat.available_for(@start_date, @end_date) }
        @flats = Flat.near([params[:lat], params[:lng]], 20).select { |flat| flat.available_for(@start_date, @end_date) }
        p @flats
      else
        @query = false
        @flats = Flat.all
      end
      # @markers = geocoded_flats(@flats, params[:lat], params[:lng])
      @markers = geocoded_flats(@flats)
    else
      flash[:error] = "Vous n'avez pas accès à cette page.'"
      redirect_to root_path
    end
  end

  def owner_profile
    redirect_to edit_user_registration_path(as: 'owner')
  end

  def medical_profile
    redirect_to edit_user_registration_path(as: 'medical')
  end

  private

  # def geocoded_flats(flats, point_lat, point_lng)
  def geocoded_flats(flats)
    flats.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude,
        # address: flat.address.gsub(" ", "&nbsp;"),
        # type: flat.flat_type.to_s,
        # distance: flat.distance_to([point_lat, point_lng]).round(2).to_s
      }
    end
  end

end
