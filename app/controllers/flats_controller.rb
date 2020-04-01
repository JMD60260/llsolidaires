class FlatsController < ApplicationController
  before_action :set_flat, only: [:edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:new, :import]

  def create
    @flat = Flat.new(flat_params)
    @flat.user_id = current_user.id
    if @flat.save
      redirect_to dashboard_owner_path
    else
      @tab = "Mes logements"
      @as = "owner"
      @flats = current_user.flats
      flash[:error] = @flat.errors.full_messages
      render 'dashboards/owner'
    end
  end

  def edit
    @tab = "Mes logements"
    @as = "owner"
    if @flat.user != current_user
      flash[:error] = "Accès interdit -> Vous devez être le propriétaire pour éditer !"
      redirect_to dashboard_owner_path
    end
  end

  def update
    if @flat.user != current_user
      flash[:error] = "Accès interdit -> Vous devez être le propriétaire pour éditer !"
      redirect_to dashboard_owner_path
    end
    if @flat.update(flat_params)
      redirect_to dashboard_owner_path
    else
      @tab = "Mes logements"
      @as = "owner"
      render :edit
    end
  end

  def destroy
    if @flat.user != current_user
      flash[:error] = "Accès interdit -> Vous devez être le propriétaire pour supprimer !"
      redirect_to dashboard_owner_path
    end
    @flat.destroy
    redirect_to dashboard_owner_path
  end

  def new
  end

  def import
    Flat.import(params[:file])
    redirect_to new_flat_path, notice: "Les propriétaires et appartements ont été ajoutés avec succès"
    flash[:succes] = "Les propriétaires et appartements ont été ajoutés avec succès"
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
                                 :photos_cache,
                                 { photos: [] }
                                 )
  end
end
