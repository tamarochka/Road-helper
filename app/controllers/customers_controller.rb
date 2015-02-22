class CustomersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @customers = Customer.all
    @geojson = Array.new
    @customers.each do |customer|
      @geojson << {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [customer.longitude, customer.latitude]
        },
        properties: {
          name: customer.name,
          address: customer.address,
          :'marker-color' => 'red',
          :'marker-symbol' => 'circle',
          :'marker-size' => 'medium'
        }
      }
    end
    respond_to do |format|
      format.html
      format.json { render json: @geojson }  # respond with the created JSON object
    end
  end

  def new
    @customer = Customer.new
    @button_name = "Create customer"
  end

  def create
    @customer = Customer.new(customer_params)
    @customer.user = current_user
    if @customer.save
      flash[:notice]= "New customer was successfully added!"
      redirect_to customers_path
    else
      flash.now[:notice]="Customer can't be added please check your address"
      render :new
    end
  end

  def show
    @customer = Customer.find(params[:id])
  end

  private
  def customer_params
    params.require(:customer).permit(:name, :address, :longtitude, :latitude)
  end
end
