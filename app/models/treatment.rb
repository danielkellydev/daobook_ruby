class Treatment < ApplicationRecord
  belongs_to :consultation

  validates :treatment_principle, presence: true
end
