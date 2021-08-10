class Airline < ApplicationRecord
  has_many :flights

  def all_distinct_adult_passengers
    flights.joins(:passengers)
           .select('passengers.*')
           .where('passengers.age >= ?', 18)
           .order('passengers.name')
           .distinct
  end
end
