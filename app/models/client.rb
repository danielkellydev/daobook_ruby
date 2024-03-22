class Client < ApplicationRecord
  belongs_to :practitioner
  belongs_to :health_fund, optional: true
  has_many :consultations
  has_many :treatments, through: :consultations
  has_many :appointments
  
  def full_name
    "#{first_name} #{last_name}"
  end
end
