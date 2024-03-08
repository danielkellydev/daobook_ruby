class ClientsController < ApplicationController
  before_action :authenticate_practitioner!
  before_action :set_client, only: [:edit, :update, :destroy]

  def index
    @clients = current_practitioner.clients
  end

  def new
    @client = current_practitioner.clients.build
    @health_funds = HealthFund.all
  end

  def create
    @client = current_practitioner.clients.build(client_params)
    if @client.save
      redirect_to clients_path, notice: 'Client created successfully.'
    else
      render :new
    end
  end

  def edit
    @health_funds = HealthFund.all
  end

  def show
    redirect_to clients_path
  end

  def update
    if @client.update(client_params)
      redirect_to clients_path, notice: 'Client updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @client.destroy
    redirect_to clients_path, notice: 'Client deleted successfully.'
  end

  private

  def set_client
    @client = current_practitioner.clients.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:first_name, :last_name, :date_of_birth, :email, :phone_number, :health_fund_id)
  end
end