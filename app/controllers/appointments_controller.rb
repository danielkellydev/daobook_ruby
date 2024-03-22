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
    Rails.logger.debug "Appointment params: #{appointment_params.inspect}"
    @appointment = Appointment.new(appointment_params)
    @appointment.practitioner_id = current_practitioner.id
    
    Rails.logger.debug "Appointment object: #{@appointment.inspect}"
    Rails.logger.debug "Appointment errors: #{@appointment.errors.full_messages}" if @appointment.errors.any?
    
    if @appointment.save
      Rails.logger.debug "Appointment saved successfully"
      redirect_to appointments_path, notice: 'Appointment created successfully.'
    else
      Rails.logger.debug "Appointment save failed"
      redirect_to new_appointment_path, alert: 'Appointment creation failed.'
    end
  end

  private

  def appointment_params
    Rails.logger.debug "Raw appointment params: #{params[:appointment].inspect}"
    permitted_params = params.permit(:client_id, :practitioner_id, :start_time, :appointment_type)
    Rails.logger.debug "Permitted appointment params: #{permitted_params.inspect}"
  
    if permitted_params[:appointment_type].present?
      appointment_type = AppointmentType.find(permitted_params[:appointment_type])
      permitted_params[:appointment_type] = appointment_type
    end
  
    permitted_params
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