class CreateTreatments < ActiveRecord::Migration[7.1]
  def change
    create_table :treatments do |t|
      t.references :consultation, null: false, foreign_key: true
      t.string :treatment_principle
      t.string :formula_name
      t.text :formula_composition
      t.string :dosage
      t.text :administration_instructions
      t.text :acupuncture
      t.text :other_modalities
      t.text :lifestyle

      t.timestamps
    end
  end
end
