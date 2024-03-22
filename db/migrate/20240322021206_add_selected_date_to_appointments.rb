class AddSelectedDateToAppointments < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :selected_date, :date
  end
end