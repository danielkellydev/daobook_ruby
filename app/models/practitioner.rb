class Practitioner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :clients
  has_many :provider_numbers, dependent: :destroy
  has_many :consultations 
  has_many :treatments, through: :consultations
  has_many :appointments
end
