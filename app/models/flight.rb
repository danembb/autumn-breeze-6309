class Flight < ApplicationRecord
  belongs_to :airline
  has_many :trips
  has_many :passengers, through: :trips
end
