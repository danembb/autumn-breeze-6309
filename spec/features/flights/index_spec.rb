require 'rails_helper'

RSpec.describe 'flights index page' do
  before :each do

    @airline1 = Airline.create!(name: "Dodo Airlines")
    @airline2 = Airline.create!(name: "Tang Airlines")

    @flight1 = @airline1.flights.create!(number: 31, date: "07/20/99", departure_city: "Bogota, Colombia", arrival_city: "Hartford, CT")
    @flight2 = @airline1.flights.create!(number: 32, date: "08/02/02", departure_city: "Northampton, MA", arrival_city: "Lakewood, CO")
    @flight3 = @airline2.flights.create!(number: 33, date: "10/31/06", departure_city: "Holyoke, MA", arrival_city: "Minneapolis, MN")

    @passenger1 = Passenger.create!(name: "Bb")
    @passenger2 = Passenger.create!(name: "Nico")
    @passenger3 = Passenger.create!(name: "Ellie")
    @passenger4 = Passenger.create!(name: "Arkham")
    @passenger5 = Passenger.create!(name: "Andromeda")

    @trip1 = Trip.create!(flight_id: @flight1.id, passenger_id: @passenger1.id)
    @trip2 = Trip.create!(flight_id: @flight1.id, passenger_id: @passenger2.id)
    @trip3 = Trip.create!(flight_id: @flight2.id, passenger_id: @passenger3.id)
    @trip4 = Trip.create!(flight_id: @flight3.id, passenger_id: @passenger4.id)
    @trip5 = Trip.create!(flight_id: @flight3.id, passenger_id: @passenger5.id)

    visit flights_path
  end

  describe 'as a visitor' do

  # User Story 1, Flights Index Page
  # As a visitor x
  # When I visit the flights index page x
  # I see a list of all flight numbers x
  # And next to each flight number I see the name of the Airline of that flight x
  # And under each flight number I see the names of all that flight's passengers t
    it 'can see flights with attributes and passengers' do
      save_and_open_page
      within "#flight-#{@flight1.id}" do
        expect(page).to have_content(@airline1.name)

        expect(page).to have_content(@flight1.number)

        expect(page).to have_content(@passenger1.name)
        expect(page).to have_content(@passenger2.name)
      end

      within "#flight-#{@flight2.id}" do
        expect(page).to have_content(@airline1.name)

        expect(page).to have_content(@flight2.number)

        expect(page).to have_content(@passenger3.name)
      end

      within "#flight-#{@flight3.id}" do
        expect(page).to have_content(@airline2.name)

        expect(page).to have_content(@flight3.number)

        expect(page).to have_content(@passenger4.name)
        expect(page).to have_content(@passenger5.name)
      end
    end
  end
end
