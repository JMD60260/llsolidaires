class DashboardsController < ApplicationController
  def index
    @flats = Flat.all
  end
  def owner
    @flats = Flat.all
  end
  def medical
    @flats = Flat.all
  end
end
