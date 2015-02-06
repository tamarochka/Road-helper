class PickUpsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @pick_ups = PickUp.all
  end

  def new
    @pick_up = PickUp.new
  end

  def create
    @pick_up = PickUp.new(pickup_params)
    @pick_up.user = current_user
    if @pick_up.save
      redirect_to pick_ups_path
    else
      render :new
    end
  end

  private
  def pickup_params
    params.require(:pick_up).permit(:location_id, :item, :date, :quantity)
  end
end
