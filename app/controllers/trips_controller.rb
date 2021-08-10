class TripsController < ApplicationController

  def destroy
    @passenger = Passenger.find(params[:id])
    @flight = Flight.find(params[:flight_id])
    Trip.find_by(passenger_id: @passenger.id, flight_id: @flight.id).delete
    redirect_to flights_path
  end
end
