class RemovePractitionerSchedulesTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :practitioner_schedules
  end
end