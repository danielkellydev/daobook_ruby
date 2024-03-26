# db/migrate/20230326123456_create_practitioner_schedules.rb
class CreatePractitionerSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :practitioner_schedules do |t|
      t.references :practitioner, null: false, foreign_key: true
      t.integer :weekday, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false

      t.timestamps
    end
  end
end