class Client < ApplicationRecord
  belongs_to :practitioner
  belongs_to :health_fund, optional: true
end
