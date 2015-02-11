class PickUpsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @pick_ups = PickUp.all
    @pickups_by_date = @pick_ups.group_by(&:date)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
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

  def edit
    @pick_up = PickUp.find(params[:id])
  end

  def update
    @pick_up =PickUp.find(params[:id])
    if @pick_up.update(pickup_params)
      flash[:notice] ="PickUp was updated!"
      redirect_to pick_up_path(@pick_up)
    else
      flash[:notice] ="PickUp couldn't be updated"
      render :edit
    end
  end

  def show
    @pick_up = PickUp.find(params[:id])
  end

  def destroy
    @pick_up = PickUp.find(params[:id])
    @pick_up.destroy
    flash[:notice] ="Pick-up was successfully deleted!"
    redirect_to pick_ups_path
  end

  private
  def pickup_params
    params.require(:pick_up).permit(:customer_id, :location_id, :item, :date, :quantity)
  end
end
