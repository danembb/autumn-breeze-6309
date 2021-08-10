require 'rails_helper'

RSpec.describe Airline do
  describe 'relationships' do
    it { should have_many(:flights) }
  end

  describe '#instance methods' do
    it 'can see only distinct passengers over 18' do
      airline1 = Airline.create!(name: "Dodo Airlines")
      airline2 = Airline.create!(name: "Tang Airlines")

      flight1 = airline1.flights.create!(number: 31, date: "07/20/99", departure_city: "Bogota, Colombia", arrival_city: "Hartford, CT")
      flight2 = airline1.flights.create!(number: 32, date: "08/02/02", departure_city: "Northampton, MA", arrival_city: "Lakewood, CO")
      flight3 = airline2.flights.create!(number: 33, date: "10/31/06", departure_city: "Holyoke, MA", arrival_city: "Minneapolis, MN")

      passenger1 = Passenger.create!(name: "Bb", age: 17)
      passenger2 = Passenger.create!(name: "Nico", age: 18)
      passenger3 = Passenger.create!(name: "Ellie", age: 67)
      passenger4 = Passenger.create!(name: "Arkham", age: 9)
      passenger5 = Passenger.create!(name: "Andromeda", age: 44)
      passenger6 = Passenger.create!(name: "Rory", age: 32)

      trip1 = Trip.create!(flight_id: flight1.id, passenger_id: passenger1.id)
      trip2 = Trip.create!(flight_id: flight1.id, passenger_id: passenger2.id)
      trip3 = Trip.create!(flight_id: flight2.id, passenger_id: passenger3.id)
      trip4 = Trip.create!(flight_id: flight3.id, passenger_id: passenger4.id)
      trip5 = Trip.create!(flight_id: flight3.id, passenger_id: passenger5.id)
      trip6 = Trip.create!(flight_id: flight1.id, passenger_id: passenger6.id)
      trip7 = Trip.create!(flight_id: flight2.id, passenger_id: passenger6.id)

      expect(airline1.all_distinct_adult_passengers.count).to eq(3)
      expect(airline1.all_distinct_adult_passengers.first.id).to eq(passenger3.id)
      expect(airline1.all_distinct_adult_passengers.last.id).to eq(passenger6.id)

      expect(airline2.all_distinct_adult_passengers.count).to eq(1)
    end

  end
end
