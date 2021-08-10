class Airline < ApplicationRecord
  has_many :flights

  def all_distinct_adult_passengers
    flights.joins(trips: :passenger)
           .select('passengers.*, count(trips.id) AS trip_total')
           .where('passengers.age >= ?', 18)
           .group('passengers.id')
           .order('trip_total desc')
           .distinct
  end
end
