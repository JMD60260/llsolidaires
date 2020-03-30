class DashboardsController < ApplicationController

  def owner
    @tab = "Mes logements"
    @role = "owner"
    @flats = current_user.flats
    @flat = Flat.new
  end

  def medical
    if current_user.role == "medical"
      @tab = "Recherche de logements"
      @role = "medical"
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
      else
        flash[:error] = "Vous n'avez pas accés à cette page.'"
        redirect_to root_path
      end
    end
    # raise

  end
