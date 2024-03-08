class AddHealthFundIdToProviderNumbers < ActiveRecord::Migration[7.1]
  def change
    add_column :provider_numbers, :health_fund_id, :integer
  end
end
