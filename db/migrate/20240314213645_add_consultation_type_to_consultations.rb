class AddConsultationTypeToConsultations < ActiveRecord::Migration[7.1]
  def change
    add_column :consultations, :consultation_type, :string
  end
end
