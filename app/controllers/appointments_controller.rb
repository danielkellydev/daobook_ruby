class AppointmentsController < ApplicationController
  before_action :set_appointment_types_and_time_options, only: [:index, :new]

  def index
    @appointments = Appointment.all
    @view = params[:view] || 'week'
  
    if @view == 'week'
      today = Date.today
      start_date = today.beginning_of_week
      end_date = today.end_of_week
      @date_range = start_date..end_date
    end
  end

  def new
    @appointment = Appointment.new
    @selected_time = params[:start_time]
    logger.debug "Selected Time in Controller: #{@selected_time}"
  end

  def show
    @appointment = Appointment.find(params[:id])
    render partial: 'appointments/show', locals: { appointment: @appointment }
  end

  def edit
    @appointment = Appointment.find(params[:id])
    @appointment_types = AppointmentType.all
    @time_options = generate_time_options
    render partial: 'appointments/edit_form', locals: { appointment: @appointment }
  end
  
  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    redirect_to appointments_path, notice: 'Appointment was successfully deleted.'
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_params)
      render json: {
        status: 'success', 
        message: 'Appointment was successfully updated.', 
        appointment_html: view_context.turbo_frame_tag("appointment_#{@appointment.id}") do 
          render_to_string(partial: 'appointments/appointment', locals: { appointment: @appointment })
        end
      }
    else
      render json: {
        status: 'error',
        message: @appointment.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.practitioner = current_practitioner
  
    if @appointment.save
      redirect_to appointments_path, notice: 'Appointment created successfully.'
    else
      render 'form', alert: 'Appointment creation failed.'
    end
  end

  private

  def appointment_params
    permitted_params = params.require(:appointment).permit(:client_id, :practitioner_id, :appointment_type, :selected_date, :start_time)
  
    if permitted_params[:selected_date].present?
      selected_date = Date.parse(permitted_params[:selected_date])
      permitted_params[:selected_date] = selected_date
    end
  
    if permitted_params[:start_time].present?
      start_time = Time.parse(permitted_params[:start_time]).in_time_zone(Time.zone)
      permitted_params[:start_time] = start_time
    end
  
    if permitted_params[:appointment_type].present?
      appointment_type = AppointmentType.find(permitted_params[:appointment_type])
      permitted_params[:appointment_type] = appointment_type
    end
  
    if permitted_params[:selected_date].present? && permitted_params[:start_time].present?
      selected_date = permitted_params[:selected_date]
      start_time = permitted_params[:start_time]
      permitted_params[:start_time] = start_time.change(year: selected_date.year, month: selected_date.month, day: selected_date.day)
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
    options << current_time
    current_time += interval
  end

  options
end

  def set_appointment_types_and_time_options
    @appointment_types = AppointmentType.all
    @time_options = generate_time_options
  end
end