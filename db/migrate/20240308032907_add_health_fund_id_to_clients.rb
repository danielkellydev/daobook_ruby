class AddHealthFundIdToClients < ActiveRecord::Migration[7.1]
  def change
    add_column :clients, :health_fund_id, :integer
  end
end
