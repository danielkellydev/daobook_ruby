class RemoveTreatmentFieldsFromConsultations < ActiveRecord::Migration[7.0]
  def change
    remove_column :consultations, :treatment_principle, :string
    remove_column :consultations, :formula_name, :string
    remove_column :consultations, :formula_composition, :text
    remove_column :consultations, :dosage, :string
    remove_column :consultations, :administration_instructions, :text
    remove_column :consultations, :acupuncture, :text
    remove_column :consultations, :other_modalities, :text
    remove_column :consultations, :lifestyle, :text
  end
end