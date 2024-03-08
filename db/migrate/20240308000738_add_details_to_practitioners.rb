class AddDetailsToPractitioners < ActiveRecord::Migration[7.1]
  def change
    add_column :practitioners, :first_name, :string
    add_column :practitioners, :last_name, :string
    add_column :practitioners, :date_of_birth, :date
    add_column :practitioners, :ahpra_number, :string
    add_column :practitioners, :phone_number, :string
  end
end
