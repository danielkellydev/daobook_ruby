class Appointment < ApplicationRecord
  belongs_to :client
  belongs_to :practitioner
  belongs_to :appointment_type, foreign_key: 'appointment_type'
end
