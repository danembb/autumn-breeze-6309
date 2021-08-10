require 'rails_helper'

RSpec.describe 'flights index page' do
  before :each do

    @airline1 = Airline.create!(name: "Dodo Airlines")
    @airline2 = Airline.create!(name: "Tang Airlines")

    @flight1 = @airline1.flights.create!(number: 31, date: "07/20/99", departure_city: "Bogota, Colombia", arrival_city: "Hartford, CT")
    @flight2 = @airline1.flights.create!(number: 32, date: "08/02/02", departure_city: "Northampton, MA", arrival_city: "Lakewood, CO")
    @flight3 = @airline2.flights.create!(number: 33, date: "10/31/06", departure_city: "Holyoke, MA", arrival_city: "Minneapolis, MN")

    @passenger1 = Passenger.create!(name: "Bb", age: 25)
    @passenger2 = Passenger.create!(name: "Nico", age: 26)
    @passenger3 = Passenger.create!(name: "Ellie", age: 67)
    @passenger4 = Passenger.create!(name: "Arkham", age: 18)
    @passenger5 = Passenger.create!(name: "Andromeda", age: 44)

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
  # And under each flight number I see the names of all that flight's passengers x
    it 'can see flights with attributes and passengers' do
      within "#flight-#{@flight1.id}" do
        expect(page).to have_content(@airline1.name)

        expect(page).to have_content(@flight1.number)

        expect(page).to have_content(@passenger1.name)
        expect(page).to have_content(@passenger2.name)
        expect(page).to_not have_content(@passenger3.name)
      end

      within "#flight-#{@flight2.id}" do
        expect(page).to have_content(@airline1.name)

        expect(page).to have_content(@flight2.number)

        expect(page).to have_content(@passenger3.name)
        expect(page).to_not have_content(@passenger4.name)
      end

      within "#flight-#{@flight3.id}" do
        expect(page).to have_content(@airline2.name)

        expect(page).to have_content(@flight3.number)

        expect(page).to_not have_content(@passenger1.name)
        expect(page).to have_content(@passenger4.name)
        expect(page).to have_content(@passenger5.name)
      end
    end

    it 'can remove a passenger from a flight' do

      # User Story 2, Remove a Passenger from a Flight
      # As a visitor x
      # When I visit the flights index page x
      # Next to each passengers name x
      # I see a link or button to remove that passenger from that flight x
      # When I click on that link/button x
      # I'm returned to the flights index page x
      # And I no longer see that passenger listed under that flight x
      # (Note: you should not destroy the passenger record entirely) x
      within "#passenger-#{@passenger1.id}" do
        expect(page).to have_link("Remove Passenger")
      end

      within "#passenger-#{@passenger2.id}" do
        expect(page).to have_link("Remove Passenger")
      end

      within "#passenger-#{@passenger3.id}" do
        expect(page).to have_link("Remove Passenger")
      end

      within "#passenger-#{@passenger4.id}" do
        expect(page).to have_link("Remove Passenger")
      end

      within "#passenger-#{@passenger5.id}" do
        expect(page).to have_link("Remove Passenger")

        click_link("Remove Passenger")

        expect(current_path).to eq(flights_path)
      end

      within "#flight-#{@flight3.id}" do
        expect(page).to_not have_content(@passenger5.name)
      end

      expect(@flight3.passengers.length).to eq(1)
      expect(Passenger.all.length).to eq(5)
    end
  end
end
