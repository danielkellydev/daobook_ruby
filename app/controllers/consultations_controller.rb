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
    render partial: 'form', locals: { consultation: @consultation } if request.format.turbo_frame?
  end

  def create
    @consultation = @client.consultations.build(permitted_params.merge(params.permit(:progress_since_last_visit, :tongue_diagnosis, :pulse_diagnosis, :abdominal_palpation, :tcm_diagnosis)))
    @consultation.practitioner = current_practitioner
   
    respond_to do |format|
      if @consultation.save
        format.html { redirect_to client_consultation_path(@client, @consultation), notice: 'Consultation was successfully created.' }
        format.turbo_stream { redirect_to client_consultation_path(@client, @consultation), notice: 'Consultation was successfully created.' }
      else
        format.html { render :new }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('consultation_form', partial: 'form', locals: { consultation: @consultation }) }
      end
    end
  end

  def show
    @consultation = Consultation.find(params[:id])
  end

  def edit
    render partial: 'form', locals: { consultation: @consultation } if request.format.turbo_frame?
  end

  def update
    if @consultation.update(consultation_params)
      redirect_to client_consultation_path(@client, @consultation), notice: 'Consultation was successfully updated.'
    else
      render :edit
    end
  end

  def consultation_fields
    @consultation = Consultation.new(consultation_type: params[:consultation_type])
    render partial: "#{@consultation.consultation_type.downcase}_consultation_fields", locals: { form: ActionView::Helpers::FormBuilder.new(nil, @consultation, view_context, {}) }
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
    params.require(:consultation).permit(
      :consultation_type,
      :chief_concern,
      :consultation_notes,
      :other_symptoms,
      :tongue_diagnosis,
      :pulse_diagnosis,
      :abdominal_palpation,
      :tcm_diagnosis,
      :progress_since_last_visit
    )
  end
end