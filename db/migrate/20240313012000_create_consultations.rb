class CreateConsultations < ActiveRecord::Migration[7.1]
  def change
    create_table :consultations do |t|
      t.references :client, null: false, foreign_key: true
      t.references :practitioner, null: false, foreign_key: true
      t.text :notes

      t.timestamps
    end
  end
end
