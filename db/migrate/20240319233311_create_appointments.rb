class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.references :client, null: false, foreign_key: true
      t.references :practitioner, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.string :appointment_type

      t.timestamps
    end
  end
end
