class CreateProviderNumbers < ActiveRecord::Migration[7.1]
  def change
    create_table :provider_numbers do |t|
      t.string :health_fund
      t.string :provider_number
      t.references :practitioner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
