class AppointmentType < ApplicationRecord
  has_many :appointments, foreign_key: 'appointment_type'
end
