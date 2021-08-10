class Airline < ApplicationRecord
  has_many :flights

  def all_distinct_adult_passengers
    wip = flights.joins(trips: :passenger)
           .select('passengers.*, count(trips.id) as trip_number')
           .where('passengers.age >= ?', 18)
           .group('passenger.id')
           .order('trip_number desc')
           .distinct
  end
end
