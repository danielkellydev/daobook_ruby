class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :email
      t.string :phone_number
      t.references :practitioner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
