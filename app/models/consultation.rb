class Consultation < ApplicationRecord
  belongs_to :client
  belongs_to :practitioner
end
