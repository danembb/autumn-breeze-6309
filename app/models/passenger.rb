class Passenger < ApplicationRecord
  has_many :trips
  has_many :flights, through: :trips
end
