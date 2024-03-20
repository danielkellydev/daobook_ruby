class AppointmentsController < ApplicationController
  before_action :set_appointment_types_and_time_options, only: [:index, :new]

  def index
    @appointments = Appointment.all
    @view = params[:view] || 'week'
  end

  def new
    @appointment = Appointment.new
  end

  def create
    Rails.logger.debug "Raw parameters: #{request.raw_post}"
    @appointment = Appointment.new(appointment_params)
    
    if appointment_type_id = params[:appointment][:appointment_type_id]
      @appointment.appointment_type = AppointmentType.find_by(id: appointment_type_id)
    end
  
    if @appointment.save
      redirect_to appointments_path, notice: 'Appointment created successfully.'
    else
      render :new
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:client_id, :practitioner_id, :start_time, :end_time, :appointment_type_id)
  end

  def generate_time_options
    start_time = Time.current.beginning_of_day
    end_time = start_time.end_of_day
    interval = 15.minutes

    options = []
    current_time = start_time

    while current_time <= end_time
      options << [current_time.strftime('%I:%M %p'), current_time]
      current_time += interval
    end

    options
  end

  def set_appointment_types_and_time_options
    @appointment_types = AppointmentType.all
    @time_options = generate_time_options
  end
end