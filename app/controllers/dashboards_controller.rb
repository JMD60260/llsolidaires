class DashboardsController < ApplicationController
  def index
    @flats = Flat.all
    @owned_flats = current_user.flats
  end
end
