class Appointment < ApplicationRecord
  belongs_to :client
  belongs_to :practitioner
  belongs_to :appointment_type, class_name: 'AppointmentType', foreign_key: 'appointment_type'
end
