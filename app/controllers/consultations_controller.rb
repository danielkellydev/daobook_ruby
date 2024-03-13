class ConsultationsController < ApplicationController
  before_action :authenticate_practitioner!
  before_action :set_client, only: [:index, :new, :create]
  before_action :set_consultation, only: [:show, :edit, :update]
  before_action :set_client_from_consultation, only: [:update]

  def index
    @consultations = @client.consultations.order(created_at: :desc)
  end

  def new
    @consultation = @client.consultations.build
  end

  def create
    @consultation = @client.consultations.build(consultation_params)
    @consultation.practitioner = current_practitioner

    if @consultation.save
      redirect_to client_consultations_path(@client), notice: 'Consultation was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @consultation.update(consultation_params)
      redirect_to client_consultations_path(@client), notice: 'Consultation was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_client
    @client = Client.find(params[:client_id])
  end

  def set_consultation
    @consultation = Consultation.find(params[:id])
  end

  def set_client_from_consultation
    @client = @consultation.client
  end

  def consultation_params
    params.require(:consultation).permit(:notes)
  end
end