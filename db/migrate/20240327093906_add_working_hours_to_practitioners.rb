class AddWorkingHoursToPractitioners < ActiveRecord::Migration[6.1]
  def change
    add_column :practitioners, :working_days, :string, default: '1111111' # '1111111' means all days are working days
    add_column :practitioners, :start_time, :time, default: '09:00'
    add_column :practitioners, :end_time, :time, default: '17:00'
  end
end