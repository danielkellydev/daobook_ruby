class PractitionerSchedule < ApplicationRecord
  belongs_to :practitioner

  validates :weekday, presence: true, inclusion: { in: 0..6 }
  validates :start_time, presence: true
  validates :end_time, presence: true
end