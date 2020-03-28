class FlatsController < ApplicationController
  before_action :set_flat, only: [:show, :edit, :update, :destroy]

  def show
    @flat = Flat.find(params[:id])
  end

  def index
    @flats = Flat.geocoded

    @markers = @flats.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude,
        # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
      }
    end
  end

  def new
    # Ligne a ajouter dans le formulaire pour ajouter les photos
    # <%= f.file_field :photos, multiple: true %>
  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def set_flat
    @flat = Flat.find(params[:id])
  end

  def flat_params
    params.require(:flat).permit(:address,
                                 :flat_type,
                                 :description,
                                 :accessibility_pmr,
                                 { photos: [] }
                                 )
  end
end
