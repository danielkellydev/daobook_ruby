class CreateAppointmentTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :appointment_types do |t|
      t.string :name
      t.integer :duration

      t.timestamps
    end
  end
end
