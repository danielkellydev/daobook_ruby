class CreateHealthFunds < ActiveRecord::Migration[7.1]
  def change
    create_table :health_funds do |t|
      t.string :name

      t.timestamps
    end
  end
end
