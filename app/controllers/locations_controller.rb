class LocationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @locations = Location.all
  end
  def new
    @location = Location.new
    @button_name = "Create location"
  end

  def create
    @location = Location.new(location_params)
    @location.user = current_user
    if @location.save
      flash[:notice]= "New location was successfully added!"
      redirect_to locations_path
    else
      flash.now[:notice]="Location can't be added please check your address"
      render :new
    end
  end

  def show
    @location = Location.find(params[:id])
  end

  def edit
    @location = Location.find(params[:id])
    @button_name = "Update location"
  end

  def update
    @location = Location.find(params[:id])
    if @location.update(location_params)
      flash[:notice] = "Location was updated successfully"
      redirect_to locations_path
    else
      flash.now[:notice] = "Your updates can't be saved"
      render :edit
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    flash[:notice] = "Location was successfully deleted!"
    redirect_to locations_path
  end

  def import
    Location.import(params[:file])
    redirect_to root_url, notice: "Locations imported."
  end

  private
  def location_params
    params.require(:location).permit(:name, :address, :longtitude, :latitude, :notes)
  end
end
