class UpdateConsultationFields < ActiveRecord::Migration[7.0]
  def change
    rename_column :consultations, :presenting_complaint, :chief_concern
    rename_column :consultations, :notes, :consultation_notes
    add_column :consultations, :progress_since_last_visit, :text
  end
end