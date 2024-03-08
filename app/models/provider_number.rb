class ProviderNumber < ApplicationRecord
  belongs_to :practitioner
  belongs_to :health_fund
end
