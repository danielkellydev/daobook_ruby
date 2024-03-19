class UpdateTreatmentsTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :treatments, :administration_instructions, :text
    remove_column :treatments, :acupuncture, :text
    remove_column :treatments, :other_modalities, :text
    remove_column :treatments, :lifestyle, :text

    add_column :treatments, :administration, :text
    add_column :treatments, :acupuncture_treatment, :text
    add_column :treatments, :diet_lifestyle, :text
    add_column :treatments, :other_treatments, :text
    add_column :treatments, :treatment_plan, :text
  end
end