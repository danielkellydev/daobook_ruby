class ProviderNumbersController < ApplicationController
  before_action :authenticate_practitioner!
  before_action :set_provider_number, only: [:edit, :update, :destroy]

  def index
    @provider_numbers = current_practitioner.provider_numbers
  end

  def new
    @provider_number = ProviderNumber.new
    @health_funds = HealthFund.all
  end

  def create
    @provider_number = current_practitioner.provider_numbers.new(provider_number_params)
    @health_funds = HealthFund.all
  
    if @provider_number.save
      redirect_to provider_numbers_path, notice: 'Provider number was successfully created.'
    else
      render :new
    end
  end

  def edit
    @health_funds = HealthFund.all
  end

  def update
    if @provider_number.update(provider_number_params)
      redirect_to provider_numbers_path, notice: 'Provider number updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @provider_number.destroy
    redirect_to provider_numbers_path, notice: 'Provider number deleted successfully.'
  end

  private

  def set_provider_number
    @provider_number = current_practitioner.provider_numbers.find(params[:id])
  end

  def provider_number_params
    params.require(:provider_number).permit(:provider_number, :health_fund_id)
  end
end