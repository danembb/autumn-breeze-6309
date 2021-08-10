require 'rails_helper'

RSpec.describe 'airlines show page' do
  before :each do

    @airline1 = Airline.create!(name: "Dodo Airlines")
    @airline2 = Airline.create!(name: "Tang Airlines")

    @flight1 = @airline1.flights.create!(number: 31, date: "07/20/99", departure_city: "Bogota, Colombia", arrival_city: "Hartford, CT")
    @flight2 = @airline1.flights.create!(number: 32, date: "08/02/02", departure_city: "Northampton, MA", arrival_city: "Lakewood, CO")
    @flight3 = @airline2.flights.create!(number: 33, date: "10/31/06", departure_city: "Holyoke, MA", arrival_city: "Minneapolis, MN")

    @passenger1 = Passenger.create!(name: "Bb", age: 17)
    @passenger2 = Passenger.create!(name: "Nico", age: 18)
    @passenger3 = Passenger.create!(name: "Ellie", age: 67)
    @passenger4 = Passenger.create!(name: "Arkham", age: 9)
    @passenger5 = Passenger.create!(name: "Andromeda", age: 44)
    @passenger6 = Passenger.create!(name: "Rory", age: 32)

    @trip1 = Trip.create!(flight_id: @flight1.id, passenger_id: @passenger1.id)
    @trip2 = Trip.create!(flight_id: @flight1.id, passenger_id: @passenger2.id)
    @trip3 = Trip.create!(flight_id: @flight2.id, passenger_id: @passenger3.id)
    @trip4 = Trip.create!(flight_id: @flight3.id, passenger_id: @passenger4.id)
    @trip5 = Trip.create!(flight_id: @flight3.id, passenger_id: @passenger5.id)
    @trip6 = Trip.create!(flight_id: @flight1.id, passenger_id: @passenger6.id)
    @trip7 = Trip.create!(flight_id: @flight2.id, passenger_id: @passenger6.id)

    visit airline_path(@airline1)
  end

  describe 'as a visitor on an airlines show page' do

  # User Story 3, Airline's Passengers
  # As a visitor x
  # When I visit an airline's show page t
  # Then I see a list of passengers that have flights on that airline t
  # And I see that this list is unique (no duplicate passengers) t
  # And I see that this list only includes adult passengers t
  # (Note: an adult is anyone with age greater than or equal to 18) t
    it 'can see a unique list of passengers on this airline who are adults' do
      expect(page).to have_content(@passenger2.name)
      expect(page).to have_content(@passenger2.age)

      expect(page).to have_content(@passenger3.name)
      expect(page).to have_content(@passenger3.age)

      #not adult
      expect(page).to_not have_content(@passenger1.name)
      expect(page).to_not have_content(@passenger1.age)

      #duplicate
      expect(page).to_not have_content(@passenger6.name)
      expect(page).to_not have_content(@passenger6.age)
    end
  end
end
